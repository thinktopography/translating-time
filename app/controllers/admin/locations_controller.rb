class Admin::LocationsController < Admin::ApplicationController

  before_filter :is_admin?

  def index
    @locations = Location.all
  end
  
  def new
    @location = Location.new
  end
  
  def create
    @location = Location.new(params[:location])
    if @location.save
      flash[:success] = 'Your location was successfully created'
      redirect_to new_admin_location_path if params[:commit] == 'Save and Continue'
      redirect_to admin_locations_path    if params[:commit] == 'Save and Finish'
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'new'
    end
  end
  
  def edit
    @location = Location.find(params[:id])
  end
  
  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(params[:location])
      flash[:success] = 'Your location was successfully updated'
      redirect_to admin_locations_path
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'edit'
    end
  end

end