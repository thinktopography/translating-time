class Admin::ExportsController < Admin::ApplicationController

  def observations
    @observations = current_user.observations
    @species = Species.unscoped.in_model.order("id ASC").all
    @events = Event.unscoped.in_model.order("id ASC").all
    @grid = {}
    Observation.active.each do |observation|
      @grid[observation.species_id] = {} if @grid[observation.species_id].blank?
      @grid[observation.species_id][observation.event_id] = observation
    end
    send_data(render_to_string('observations'), :filename => "observation-export-#{Time.now.strftime("%y-%m-%d")}.txt", :type => "application/text", :disposition => "inline") and return
  end

  def species
    @species = Species.unscoped.in_model.order("id ASC").all
    send_data(render_to_string('species'), :filename => "species-export-#{Time.now.strftime("%y-%m-%d")}.txt", :type => "application/text", :disposition => "inline") and return
  end

  def events
    @events = Event.unscoped.in_model.order("id ASC").all
    send_data(render_to_string('events'), :filename => "events-export-#{Time.now.strftime("%y-%m-%d")}.txt", :type => "application/text", :disposition => "inline") and return
  end

end
