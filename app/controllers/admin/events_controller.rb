class Admin::EventsController < Admin::ApplicationController

  def index
    @events = Event.order('name ASC').all
  end
  
  def batch
    unless params[:item].nil?
      if ['destroy'].include?(params[:type])
        params[:item].each do |id|
          event = Event.find(id)
          event.send(params[:type])
        end
      end
      flash[:success] = "This batch operation was successfully performed."
    end
    redirect_to admin_events_path
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      flash[:success] = 'The event was successfully created'
      redirect_to new_admin_event_path if params[:commit] == 'Save and Continue'
      redirect_to admin_events_path    if params[:commit] == 'Save and Finish'
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      flash[:success] = 'The event was successfully updated'
      redirect_to admin_events_path
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'edit'
    end
  end

end