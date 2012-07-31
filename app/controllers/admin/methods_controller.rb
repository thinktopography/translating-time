class Admin::MethodsController < Admin::ApplicationController

  before_filter :is_admin?

  def index
    @methods = Methodd.all
  end

  def new
    @method = Methodd.new
  end

  def create
    @method = Methodd.new(params[:methodd])
    if @method.save
      flash[:success] = 'The method was successfully created'
      redirect_to new_admin_method_path if params[:commit] == 'Save and Continue'
      redirect_to admin_methods_path    if params[:commit] == 'Save and Finish'
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'new'
    end
  end

  def edit
    @method = Methodd.find(params[:id])
  end

  def update
    @method = Methodd.find(params[:id])
    if @method.update_attributes(params[:methodd])
      flash[:success] = 'The method was successfully updated'
      redirect_to admin_methods_path
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'edit'
    end
  end

end