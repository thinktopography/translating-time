class TablesController < ApplicationController

  before_filter :load_menu

  def index
  end

  def empirical
    @species = Species.find(params[:id])
    @observations = @species.observations.includes(:event,:citation).active.order("events.name ASC").all
  end  

  def events
    @location = Location.find(params[:id])
    @events = @location.events.in_model.order("events.name ASC").all
  end  
  
  def abbreviations
    @abbreviations = Abbreviation.all
  end
  
  def estimates
    @species = Species.find(params[:id])
    @estimates = @species.estimates.includes(:event).order("events.name ASC").all
  end

  private
  
    def load_menu
      @items = MenuItem.all
    end


end