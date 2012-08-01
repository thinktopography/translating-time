class Admin::ProcessesController < Admin::ApplicationController

  before_filter :is_admin?

  def index
    @processes = Proces.all
  end

  def new
    @process = Proces.new
  end

  def create
    @process = Proces.new(params[:proces])
    if @process.save
      flash[:success] = 'The process was successfully created'
      redirect_to new_admin_process_path if params[:commit] == 'Save and Continue'
      redirect_to admin_processes_path    if params[:commit] == 'Save and Finish'
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'new'
    end
  end

  def edit
    @process = Proces.find(params[:id])
  end

  def update
    @process = Proces.find(params[:id])
    if @process.update_attributes(params[:proces])
      flash[:success] = 'The process was successfully updated'
      redirect_to admin_processes_path
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'edit'
    end
  end
end