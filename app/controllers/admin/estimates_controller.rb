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
        ValueImport.new(params[:upload][:values]).process
      end
      if params[:upload][:lows]
        LowImport.new(params[:upload][:lows]).process
      end
      if params[:upload][:highs]
        HighImport.new(params[:upload][:highs]).process
      end
      if params[:upload][:warnings]
        WarningImport.new(params[:upload][:warnings]).process
      end
      flash[:success] = 'Your estimates were successfully imported'
      redirect_to admin_estimates_path
    end
  end
    
end