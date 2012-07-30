class Admin::CitationsController < Admin::ApplicationController

  def index
    @citations = Citation.all
  end
  
  def new
    @citation = Citation.new
  end
  
  def create
    @citation = Citation.new(params[:citation])
    if @citation.save
      flash[:success] = 'Your citation was successfully created'
      redirect_to new_admin_citation_path
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