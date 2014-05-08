class Admin::CitationsController < Admin::ApplicationController
  
  before_filter :is_editor?

  def index
    @citations = Citation.unscoped.order('id DESC').all
  end
  
  def new
    @citation = Citation.new
  end
  
  def create
    @citation = Citation.new(params[:citation])
    if @citation.save
      flash[:success] = 'Your citation was successfully created'
      redirect_to admin_citations_path
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'new'
    end
  end
  
  def edit
    @citation = Citation.find(params[:id])
  end
  
  def update
    @citation = Citation.find(params[:id])
    if @citation.update_attributes(params[:citation])
      flash[:success] = 'Your citation was successfully updated'
      redirect_to admin_citations_path
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'edit'
    end
  end

end