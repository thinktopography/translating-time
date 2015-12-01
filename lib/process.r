library("reshape2", lib.loc="/Library/Frameworks/R.framework/Versions/3.2/Resources/library")
library("stats", lib.loc="/Library/Frameworks/R.framework/Versions/3.2/Resources/library")

days.allobs <- read.csv("./observations.txt",header=F )
days.allobs <- days.allobs[,-dim(days.allobs)[2]]
colnames(days.allobs) <- c("blank" , as.character(days.allobs[1,2:dim(days.allobs)[2]]))
days.allobs[1,1] <- 999
rownames(days.allobs) <- days.allobs[,1]
days.allobs <- days.allobs[-1,-1]
N.events <-  dim(days.allobs)[1]
N.species <-  dim(days.allobs)[2]

days.allobs.melt <- melt(days.allobs[,1:N.species])
days.speciesraw <- days.allobs.melt[,1] # extracting species-code vector in "factor" form
days.allobs.melt[,1]  <- as.numeric(as.character(days.speciesraw)) 
days.allobs.melt[,3] <- log(days.allobs.melt[,2]) 
days.allobs.melt[,4] <- as.numeric(rep(rownames(days.allobs), N.species)) 
days.allobs.melt[,5]  <- days.speciesraw
days.allobs.melt[,6]  <- as.factor(rep(rownames(days.allobs), N.species)) 
days.onlyobs.melt  <- days.allobs.melt[!is.na(days.allobs.melt[,2]),] # culling out rows with NA entires
days.onlyobs.melt[,5] <- match(days.onlyobs.melt[,5],unique(days.onlyobs.melt[,5]))
days.onlyobs.melt[,6] <- match(days.onlyobs.melt[,6],unique(days.onlyobs.melt[,6]))
colnames(days.onlyobs.melt)=c("species","obs.day", "obs.day.log", "eventnum","species.index","eventnum.index")
days.onlyobs.melt$obs.day.log <- round(days.onlyobs.melt$obs.day.log, digits=3) # rounding
model.obs <- days.onlyobs.melt$obs.day.log

N.obs.byEvent <- colSums(table(days.onlyobs.melt$species, days.onlyobs.melt$eventnum)) # Number of observations by event
N.obs.bySpecies <- rowSums(table(days.onlyobs.melt$species, days.onlyobs.melt$eventnum)) # Number of observations by species
eventscore0 <- days.onlyobs.melt[which.min(days.onlyobs.melt$obs.day),]$eventnum.index
eventscore1 <- days.onlyobs.melt[which.max(days.onlyobs.melt$obs.day),]$eventnum.index
N.validevents <- length(unique(days.onlyobs.melt$eventnum))
N.validspecies<- length(unique(days.onlyobs.melt$species))
modelSSE <- function(model.X) {  
  model.X[eventscore0 + N.validspecies*2] <- 0; model.X[eventscore1 + N.validspecies*2] <- 1   
  model.constants <- model.X[1:N.validspecies][days.onlyobs.melt$species.index] 
  model.slopes <- model.X[(N.validspecies+1):(N.validspecies*2)][days.onlyobs.melt$species.index] 
  model.eventscores <- model.X[(N.validspecies*2+1):(N.validspecies*2+N.validevents)][days.onlyobs.melt$eventnum.index]    
  sum((( model.slopes * model.eventscores + model.constants ) -  model.obs) ^ 2) 
} 
result <- optim(rep(0,N.validspecies*2+N.validevents), method="L-BFGS-B" , modelSSE, control=list(trace=TRUE, maxit=3000))
result$par[eventscore0 + N.validspecies*2] <- 0; result$par[eventscore1 + N.validspecies*2] <- 1 
eventscore0 <- which.min(result$par[(N.validspecies*2+1):(N.species*2+N.validevents)]) # reassessment of which event to select as eventscore 0 
eventscore1 <- which.max(result$par[(N.validspecies*2+1):(N.species*2+N.validevents)]) # likewise for eventscore 1
run.again <- (result$par[N.validspecies*2 + eventscore0] <0) | (result$par[N.validspecies*2 + eventscore1] >1) 
if (run.again==T) # running optimization again if it turns out that previous anchor events were not the earliest/latest on eventscale.
{
  result <- optim(rep(0,N.validspecies*2+N.validevents), method="L-BFGS-B" , modelSSE, control=list(trace=TRUE, maxit=3000))
  result$par[eventscore0 + N.validspecies*2] <- 0; result$par[eventscore1 + N.validspecies*2] <- 1 
}

map1A <- days.onlyobs.melt[match(unique(days.onlyobs.melt$eventnum), days.onlyobs.melt$eventnum),]$eventnum
map1B <- c(map1A, setdiff(1:N.events, map1A)) # Each position represents an eventnum.index. Each entry is an eventnum. 
result.row.order <- sort(map1B,index.return=T)$ix # Each position represents an eventnum. Each entry is an eventnum.index.
map2A <- days.onlyobs.melt[match(unique(days.onlyobs.melt$species), days.onlyobs.melt$species),]$species # Each position represents a species.index, each entry is a species number
result.col.order <- sort(map2A,index.return=T)$ix # Each position represents a species code. Each engtry is a species.index
result.constants.indexed <- round(result$par[1:N.validspecies], digits=3)
result.slopes.indexed <- round(result$par[(N.validspecies+1):(N.validspecies*2)], digits=3)
result.eventscores.indexed <- round(result$par[(N.validspecies*2+1):(N.species*2+N.validevents)], digits=3)
result.predictions.indexed <- sweep((result.slopes.indexed %o% result.eventscores.indexed) , 1, result.constants.indexed, "+")
result.predictions.indexed <- t(round(exp(result.predictions.indexed),digits=1)) 
result.predictions.indexed <- rbind(result.predictions.indexed, matrix(NA,N.events-N.validevents,N.validspecies)) # restore columns that had no observations

result.constants <- result.constants.indexed[result.col.order]
result.slopes <- result.slopes.indexed[result.col.order]
result.eventscores <- c(result.eventscores.indexed, rep(NA,N.events-N.validevents))[result.row.order] 
result.SSE <- result$value
result.counts <- result$counts # number of times optim gradient was computed
result.predictions <- result.predictions.indexed[result.row.order, result.col.order] # table of predicted dates for each event, for each species. Row number corresponds to "event code", column number corresponds to "species code"
result.predictions.withrowandcolumnnames <- cbind(1:dim(result.predictions)[1], result.predictions)
result.predictions.withrowandcolumnnames <- rbind(c(NA, 1:dim(result.predictions)[2]), result.predictions.withrowandcolumnnames)

write.table(result.predictions.withrowandcolumnnames, file = "estimates.txt",row.names=FALSE, na="",col.names=FALSE, sep=",")