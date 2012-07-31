class Admin::ObservationsController < Admin::ApplicationController

  before_filter :is_editor?

  def index
    @observations = Observation.all
  end
  
  def new
    @observation = Observation.new
  end
  
  def create
    @observation = Observation.new(params[:observation])
    if @observation.save
      flash[:success] = 'Your observation was successfully created'
      redirect_to new_admin_observation_path   if params[:commit] == 'Save and Continue'
      redirect_to admin_observations_path if params[:commit] == 'Save and Finish'
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'new'
    end
  end
  
  def edit
    @observation = Observation.find(params[:id])
  end
  
  def update
    @observation = Observation.find(params[:id])
    if @observation.update_attributes(params[:observation])
      flash[:success] = 'Your observation was successfully updated'
      redirect_to admin_observations_path
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'edit'
    end
  end

end