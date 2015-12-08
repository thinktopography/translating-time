class Admin::ExportsController < Admin::ApplicationController

  def observations
    observations = Observation.export
    send_data(observations, :filename => "observation-export-#{Time.now.strftime("%y-%m-%d")}.txt", :type => "application/text", :disposition => "inline") and return
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
