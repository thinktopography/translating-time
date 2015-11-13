class Admin::DatasetsController < ApplicationController

  def index
    @datasets = Dataset.all
  end
  
  def new
    @datasets = Dataset.new
  end
  
  def create
    @datasets = Dataset.new(allowed_params)
    if @datasets.save
      flash[:success] = 'Your datasets was successfully created'
      redirect_to new_admin_datasets_path   if params[:commit] == 'Save and Continue'
      redirect_to admin_datasets_index_path if params[:commit] == 'Save and Finish'
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'new'
    end
  end
  
  def edit
    @datasets = Dataset.find(params[:id])
  end
  
  def update
    @datasets = Dataset.find(params[:id])
    if @datasets.update_attributes(allowed_params)
      flash[:success] = 'Your datasets was successfully updated'
      redirect_to admin_datasets_index_path
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'edit'
    end
  end

  def delete
    @datasets = Dataset.find(params[:id])
    params[:strategy] = 'delete'
  end
  
  def destroy
    @datasets = Dataset.find(params[:id])
    if params[:strategy] == 'delete'
      Observation.where(:datasets_id => @datasets.id).delete_all
      flash[:success] = 'The datasets was successfully deleted and all observations were deleted'
    elsif params[:strategy] == 'move'
      @datasets.observations.update_all(:datasets_id => params[:datasets_id])
      new_datasets = Dataset.find(params[:datasets_id])
      flash[:success] = "The datasets was successfully deleted and all observations were moved to <strong>#{new_datasets.name}</strong>"
    else
      flash[:success] = "The datasets was successfully deleted"
    end
    @datasets.destroy
    redirect_to admin_datasets_index_path
  end
  
  private 
  
    def allowed_params
      params.require(:datasets).permit([:name, :scientific_name, :code, :constant, :slope, :precocial_score, :brain, :weight, :gestation, :in_model, :taxonomy_ids])
    end

end