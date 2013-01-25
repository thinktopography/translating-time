class Admin::ItemsController < Admin::ApplicationController

  def index
    @items = MenuItem.all
  end

  def new
    @item = MenuItem.new
  end

  def create
    @item = MenuItem.new(params[:menu_item])
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
    if @item.update_attributes params[:menu_item]
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
  
end
