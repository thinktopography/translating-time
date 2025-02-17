# encoding: UTF-8

class SiteController < ApplicationController
  
  before_filter :load_menu

  def page
    @items = MenuItem.all
    @page = Page.find_by_permalink params[:permalink]
    render '404' if @page.nil?
  end
  
  def translate
    @translation = Translation.new
    params[:translation] ||= {}
    params[:translation][:species_1] ||= 0
    params[:translation][:species_2] ||= 0
    if request.post?
      @translation.attributes = params[:translation]
      if @translation.valid?
        @species1 = Species.find(params[:translation][:species_1])
        @species2 = Species.find(params[:translation][:species_2])
        @location = Location.find(params[:translation][:location])
        @process = Proces.find(params[:translation][:process])
        @result = @species1.translate(@species2, @location, @process, params[:translation][:days])
        @results = {}
        @species1.estimates.active.includes(:event).order('events.name').each do |estimate|
          begin
            @results[estimate.event.name] = []
            @results[estimate.event.name] << estimate.low
            @results[estimate.event.name] << estimate.value
            @results[estimate.event.name] << estimate.high
          rescue
            raise estimate.inspect
          end
        end
        @species2.estimates.includes(:event).each do |estimate|
          unless @results[estimate.event.name].nil?
            @results[estimate.event.name] << estimate.low
            @results[estimate.event.name] << estimate.value
            @results[estimate.event.name] << estimate.high
          end
        end
      else
        flash[:error] = 'There were problems with your input'
      end
    end
  end
  
  def predict
    params[:species_id] ||= 0
    params[:event_id] ||= 0
    if request.post?
      @species = Species.find(params[:species_id])
      @event = Event.find(params[:event_id])
      @estimate = @species.estimates.active.where(:event_id => params[:event_id]).first
    end
  end
  
  def tables
    if request.post?
    end
  end
  
  def species
    @species = Species.in_model.all
  end
  
  def feedback
    @inquiry = Inquiry.new
    if request.post?
      @inquiry.attributes = params.require(:inquiry).permit([])
      if @inquiry.save
        flash[:success] = 'Your feedback was successfully received'
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