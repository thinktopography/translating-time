class Admin::ErrorsController < Admin::ApplicationController

  before_filter :is_admin?

  def index
    @errors = Error.all
    @species = Species.order("name ASC").all
    @events = Event.order("name ASC").all
    @grid = {}
    @errors.each do |error|
      @grid[error.species_id] = {} if @grid[error.species_id].blank?
      @grid[error.species_id][error.event_id] = error
    end
  end
  
  def import
    if params[:upload]
      data = params[:upload][:file].read
      matrix = Import.new(data, 7, 2).process
      Error.delete_all
      matrix.each do |event_id, values|
        values.each do |species_id, value|
          Error.create(:species_id => species_id, :event_id => event_id, :value => value)
        end
      end
      flash[:success] = 'Your standard error file was successfully imported'
      redirect_to admin_errors_path
    end
  end
    
end