class Admin::DatasetsController < Admin::ApplicationController

  def index
    @datasets = Dataset.order(:created_at => :desc).all
  end
  
  def new
    @dataset = Dataset.new
  end
  
  def create
    @dataset = Dataset.new(allowed_params)
    @dataset.user_id = current_user.id
    if @dataset.save
      flash[:success] = 'Your datasets was successfully created'
      redirect_to admin_datasets_path
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'new'
    end
  end

  def delete
    @dataset = Dataset.find(params[:id])
    params[:strategy] = 'delete'
  end
  
  def destroy
    @dataset = Dataset.find(params[:id])
    @dataset.destroy
    redirect_to admin_datasets_index_path
  end
  
  private 
  
    def allowed_params
      params.require(:dataset).permit([:model_id])
    end

end