class TablesController < ApplicationController

  before_filter :load_menu

  def index
  end

  def empirical
    @species = Species.find(params[:id])
    @observations = @species.observations.includes(:event,:citation).active.order("events.name ASC").all
  end  

  def events
    @process = Proces.new(:name => params[:id])
    @events = Event.order("events.name ASC").all
  end  

  private
  
    def load_menu
      @items = MenuItem.all
    end


end