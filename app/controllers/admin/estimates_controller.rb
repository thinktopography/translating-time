class Admin::EstimatesController < Admin::ApplicationController

  before_filter :is_admin?

  def index
    @estimates = Estimate.all
    @species = Species.order("name ASC").all
    @events = Event.order("name ASC").all
    @grid = {}
    @estimates.each do |estimate|
      @grid[estimate.species_id] = {} if @grid[estimate.species_id].blank?
      @grid[estimate.species_id][estimate.event_id] = estimate
    end
  end
  
  def import
    if params[:upload]
      data = params[:upload][:file].read
      matrix = Import.new(data, 5, 2).process
      Estimate.delete_all
      matrix.each do |event_id, values|
        values.each do |species_id, value|
          Estimate.create(:species_id => species_id, :event_id => event_id, :value => value)
        end
      end
      flash[:success] = 'Your estimates were successfully imported'
      redirect_to admin_estimates_path
    end
  end
    
end