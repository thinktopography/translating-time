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
      if params[:upload][:values]
        Import.new(params[:upload][:values], 'value', 6, 1).process
      end
      if params[:upload][:lows]
        Import.new(params[:upload][:lows], 'low', 6, 1).process
      end
      if params[:upload][:highs]
        Import.new(params[:upload][:highs], 'high', 6, 1).process
      end
      if params[:upload][:warnings]
        Import.new(params[:upload][:warnings], 'warning', 3, 1).process
      end
      flash[:success] = 'Your estimates were successfully imported'
      redirect_to admin_estimates_path
    end
  end
    
end