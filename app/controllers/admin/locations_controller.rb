class Admin::LocationsController < ApplicationController

  def index
    @locations = Location.all
  end
  
  def new
    @location = Location.new
  end
  
  def create
    @location = Location.new params[:location]
    if @location.save
      flash[:success] = 'Your invoice was successfully created'
      redirect_to admin_locations_path
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'new'
    end
  end

end