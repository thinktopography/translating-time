class Admin::SpeciesController < Admin::ApplicationController

  def index
    @species = Species.all
  end

  def batch
    unless params[:item].nil?
      if ['destroy'].include?(params[:type])
        params[:item].each do |id|
          species = Species.find(id)
          species.send(params[:type])
        end
      end
      flash[:success] = "This batch operation was successfully performed."
    end
    redirect_to admin_species_index_path
  end
  
  def new
    @species = Species.new
  end
  
  def create
    @species = Species.new(allowed_params)
    if @species.save
      flash[:success] = 'Your species was successfully created'
      redirect_to new_admin_species_path   if params[:commit] == 'Save and Continue'
      redirect_to admin_species_index_path if params[:commit] == 'Save and Finish'
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'new'
    end
  end
  
  def edit
    @species = Species.find(params[:id])
  end
  
  def update
    @species = Species.find(params[:id])
    if @species.update_attributes(allowed_params)
      flash[:success] = 'Your species was successfully updated'
      redirect_to admin_species_index_path
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'edit'
    end
  end

  def delete
    @species = Species.find(params[:id])
    params[:strategy] = 'delete'
  end
  
  def destroy
    @species = Species.find(params[:id])
    if params[:strategy] == 'delete'
      Observation.where(:species_id => @species.id).delete_all
      flash[:success] = 'The species was successfully deleted and all observations were deleted'
    elsif params[:strategy] == 'move'
      @species.observations.update_all(:species_id => params[:species_id])
      new_species = Species.find(params[:species_id])
      flash[:success] = "The species was successfully deleted and all observations were moved to <strong>#{new_species.name}</strong>"
    else
      flash[:success] = "The species was successfully deleted"
    end
    @species.destroy
    redirect_to admin_species_index_path
  end
  
  private 
  
    def allowed_params
      params.require(:species).permit([:name, :scientific_name, :code, :constant, :slope, :precocial_score, :brain, :weight, :gestation, :in_model, :taxonomy_ids])
    end  

end