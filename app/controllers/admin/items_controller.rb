class Admin::ItemsController < Admin::ApplicationController

  def index
    @items = MenuItem.all
  end

  def new
    @item = MenuItem.new
  end

  def create
    @item = MenuItem.new(allowed_params)
    if @item.save
      flash[:success] = 'The item was successfully created'
      redirect_to admin_items_path
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'new'
    end
  end

  def edit
    @item = MenuItem.find params[:id]
  end

  def update
    @item = MenuItem.find params[:id]
    if @item.update_attributes(allowed_params)
      flash[:notice] = "This item has been successfully updated"
      redirect_to admin_items_url
    else
      flash[:warning] = "There was a problem with your input"
      render "edit"
    end
  end
  
  def delete
    @item = MenuItem.find params[:id]
  end

  def destroy
    @item = MenuItem.find params[:id]
    if  @item.destroy
      flash[:notice] = "This item was successfully deleted"
    else
      flash[:warning] = "Unable to delete item"
    end
    redirect_to admin_items_url
  end  
  
  private 
  
    def allowed_params
      params.require(:menu_item).permit([:title, :url, :target])
    end
  
end
