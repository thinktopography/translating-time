class Admin::SpeciesController < Admin::ApplicationController

  before_filter :is_admin?

  def index
    @species = Species.all
  end
  
  def new
    @species = Species.new
  end
  
  def create
    @species = Species.new(params[:species])
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
    if @species.update_attributes(params[:species])
      flash[:success] = 'Your species was successfully updated'
      redirect_to admin_species_index_path
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'edit'
    end
  end
  
end