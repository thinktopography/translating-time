class Admin::ObservationsController < Admin::ApplicationController

  before_filter :is_editor?

  def index
    params[:type] ||= 'list'
    @observations = current_user.observations
    @species = Species.order("name ASC").all
    @events = Event.order("name ASC").all
    @grid = {}
    @observations.each do |observation|
      @grid[observation.species_id] = {} if @grid[observation.species_id].blank?
      @grid[observation.species_id][observation.event_id] = observation
    end
  end
  
  def new
    @observation = current_user.observations.build
  end
  
  def create
    @observation = current_user.observations.build(params[:observation])
    if @observation.save
      flash[:success] = 'Your observation was successfully created'
      redirect_to new_admin_observation_path   if params[:commit] == 'Save and Continue'
      redirect_to admin_observations_path if params[:commit] == 'Save and Finish'
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'new'
    end
  end
  
  def edit
    @observation = Observation.find(params[:id])
  end
  
  def update
    @observation = Observation.find(params[:id])
    if @observation.update_attributes(params[:observation])
      flash[:success] = 'Your observation was successfully updated'
      redirect_to admin_observations_path
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'edit'
    end
  end
  
  def destroy
    @observation = Observation.find(params[:id])
    @observation.destroy
    render :text => ''
  end
  
  def curate
    @species = (params.has_key?(:species_id)) ? Species.find(params[:species_id]) : Species.first
    @observations = @species.observations
    @specieses = Species.all
    @events = Event.all
    @users = User.observers.all
    @grid = {}
    @observations.each do |observation|
      @grid[observation.event_id] = {} if @grid[observation.event_id].blank?
      @grid[observation.event_id][observation.user_id] = observation
    end
  end
  
  def adjust
    @observation = Observation.find(params[:id])
    Observation.update_all({ :is_active => 0 }, { :event_id => @observation.event_id, :species_id => @observation.species_id })
    @observation.is_active = 1
    @observation.save
    render :text => ''
  end
  
  def export
    params[:type] ||= 'list'
    @observations = current_user.observations
    @species = Species.order("name ASC").all
    @events = Event.order("name ASC").all
    @grid = {}
    Observation.active.each do |observation|
      @grid[observation.species_id] = {} if @grid[observation.species_id].blank?
      @grid[observation.species_id][observation.event_id] = observation.value
    end
    if params[:format] == 'txt'
      send_data(render_to_string('export'), :filename => "export-#{Time.now.strftime("%y-%m-%d")}.txt", :type => "application/text", :disposition => "inline")
    elsif params[:format] == 'csv'
      send_data(render_to_string('export'), :filename => "export-#{Time.now.strftime("%y-%m-%d")}.csv", :type => "application/text", :disposition => "inline")
    end
  end
  
  def user_form
    @species = Species.all
    @events = Event.all
    @users = User.all
  end
  
  def user
    @observations = Observation
    @observations = @observations.where(:species_id => params[:species_ids]) unless params[:species_ids].blank?
    @observations = @observations.where(:event_id => params[:event_ids]) unless params[:event_ids].blank?
    @observations = @observations.where(:user_id => params[:user_id]) unless params[:user_id].blank?
    @species = Species
    @species = @species.where(:id => params[:species_ids]) unless params[:species_ids].blank?
    @species = @species.all
    @events = Event
    @events = @events.where(:id => params[:event_ids]) unless params[:event_ids].blank?
    @events = @events.all
    @grid = {}
    @observations.each do |observation|
      @grid[observation.species_id] = {} if @grid[observation.species_id].blank?
      @grid[observation.species_id][observation.event_id] = observation
    end    
  end

  def curated_form
    @species = Species.all
    @events = Event.all
  end
  
  def curated
    @observations = Observation.active
    @observations = @observations.where(:species_id => params[:species_ids]) unless params[:species_ids].blank?
    @observations = @observations.where(:event_id => params[:event_ids]) unless params[:event_ids].blank?
    @species = Species
    @species = @species.where(:id => params[:species_ids]) unless params[:species_ids].blank?
    @species = @species.all
    @events = Event
    @events = @events.where(:id => params[:event_ids]) unless params[:event_ids].blank?
    @events = @events.all
    @grid = {}
    @observations.each do |observation|
      @grid[observation.species_id] = {} if @grid[observation.species_id].blank?
      @grid[observation.species_id][observation.event_id] = observation
    end
  end
    
end