class SiteController < ApplicationController
  
  before_filter :load_menu
  
  def rebuild
    file = File.open("#{Rails.root}/test/data.txt", "r")
    data = file.read
    file.close
    lines = data.gsub(/\r\n/, "\r").gsub(/\n/, "\r").split("\r")
    lines.shift
    species = []    
    line = lines.shift.split("\t")
    line[3,line.length].each do |code|
      species << Species.find_by_code(code)
    end
    lines.shift
    code = 272
    citation = Citation.create(:body => 'placeholder')
    lines.each do |line|
      cols = line.split("\t")
      name = cols.shift
      location = Location.find_by_code(cols.shift)
      process = Proces.find_by_code(cols.shift)
      event = Event.find_by_name(name)
      if event.blank?
        event = Event.create(:location_id => location.id, :process_id => process.id, :name => name, :code => code)
        code += 1
      end
      species.each do |species|
        value = cols.shift
        if value.present?
          observation = event.observations.build(:value => value, :species_id => species.id, :citation_id => citation.id, :user_id => 12, :is_active => false)
          observation.save(:validate => false)
        end
      end
    end
  end

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
        @species1.estimates.includes(:event).order('events.name').each do |estimate|
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
      @estimate = @species.estimates.where(:event_id => params[:event_id]).first
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
      @inquiry.attributes = params[:inquiry]
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