class Admin::ObservationsController < Admin::ApplicationController

  def index
    @observations = Observation.all
  end

end