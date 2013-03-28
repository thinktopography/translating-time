class SiteController < ApplicationController
  
  before_filter :load_menu

  def page
    @items = MenuItem.all
    @page = Page.find_by_permalink params[:permalink]
    render '404' if @page.nil?
  end
  
  def translate
    params[:species_1] ||= 0
    params[:species_2] ||= 0
    if request.post?
      @species1 = Species.find(params[:species_1])
      @species2 = Species.find(params[:species_2])
      @results = {}
      @species1.estimates.includes(:event).order('events.name').each do |estimate|
        @results[estimate.event.name] = []
        @results[estimate.event.name] << estimate.low
        @results[estimate.event.name] << estimate.value
        @results[estimate.event.name] << estimate.high
      end
      @species2.estimates.includes(:event).each do |estimate|
        unless @results[estimate.event.name].nil?
          @results[estimate.event.name] << estimate.low
          @results[estimate.event.name] << estimate.value
          @results[estimate.event.name] << estimate.high
        end
      end
    end
  end
  
  def predict
    params[:species_id] ||= 0
    params[:event_id] ||= 0
    if request.post?
      @species = Species.find(params[:species_id])
      @event = Event.find(params[:event_id])
      @estimate = @species.estimates.where(:event_id => params[:event_id]).first
      @gestation = @species.estimates.where(:event_id => 379).first
      @eyes = @species.estimates.where(:event_id => 270).first
    end
  end
  
  def tables
    if request.post?
    end
  end
  
  def feedback
    @inquiry = Inquiry.new
    if request.post?
      @inquiry.attributes = params[:inquiry]
      if @inquiry.save
        flash[:success] = 'Your feedback was successfully reveived'
        redirect_to feedback_path
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