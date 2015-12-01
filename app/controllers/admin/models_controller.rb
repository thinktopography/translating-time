class Admin::ModelsController < Admin::ApplicationController

  def index
    @models = Model.order(:created_at => :desc).all
  end

  def new
    @model = Model.new
  end

  def create
    @model = Model.new(allowed_params)
    if @model.save
      flash[:success] = 'The method was successfully created'
      redirect_to admin_models_path
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'new'
    end
  end

  def edit
    @model = Model.find(params[:id])
  end

  def update
    @model = Model.find(params[:id])
    if @model.update_attributes(allowed_params)
      flash[:success] = 'The method was successfully updated'
      redirect_to admin_models_path
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'edit'
    end
  end

  private

  def allowed_params
    params.require(:model).permit([:source])
  end

end
