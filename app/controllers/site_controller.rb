class SiteController < ApplicationController
  
  before_filter :load_menu

  def page
    @items = MenuItem.all
    @page = Page.find_by_permalink params[:permalink]
    render '404' if @page.nil?
  end
  
  def feedback
    @inquiry = Inquiry.new
    if request.post?
      @inquiry.attributes = params[:inquiry]
      if @inquiry.save
        flash[:success] = 'Your feedback was successfully reveived'
        redirect_to contact_path
      else
        flash[:error] = 'There were problems with your input'
      end
    end
  end
  
  private
  
    def load_menu
      @items = MenuItem.all
    end
    

end