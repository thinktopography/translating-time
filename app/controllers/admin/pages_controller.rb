class Admin::PagesController < Admin::ApplicationController

  def index
    params[:records] ||= '50'
    params[:page] ||= '1'
    params[:sort] ||= 'title'
    params[:order] ||= 'ASC'
    @pages = Page.order(params[:sort]+' '+params[:order]).paginate(:per_page => params[:records], :page => params[:page])
  end
  
  def batch
    unless params[:item].nil?
      if ['publish','unpublish','destroy'].include? params[:type]
        params[:item].each do |id|
          page = Page.find id
          page.send(params[:type])
        end
      end
      flash[:notice] = "This batch operation was successfully performed."
    end
    redirect_to admin_pages_url
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new params[:page]
    @page.commit(allowed_params)
    if @page.save
      flash[:notice] = "This page has been successfully created"
      redirect_to admin_pages_url
    else
      flash[:warning] = "There was a problem with your input"
      render "new"
    end
  end

  def edit
    @page = Page.find params[:id]
  end

  def update
    @page = Page.find params[:id]
    @page.commit(params[:commit])
    if @page.update_attributes(allowed_params)
      flash[:notice] = "This page has been successfully updated"
      redirect_to admin_pages_url
    else
      flash[:warning] = "There was a problem with your input"
      render "edit"
    end
  end
  
  def delete
    @page = Page.find params[:id]
  end

  def destroy
    @page = Page.find params[:id]
    if  @page.destroy
      flash[:notice] = "This page was successfully deleted"
    else
      flash[:warning] = "Unable to delete page"
    end
    redirect_to admin_pages_url
  end
  
  private 
  
    def allowed_params
      params.require(:page).permit([:title, :permalink, :is_published, :body, :meta_keywords, :meta_description, :delete_asset])
    end
  
end
