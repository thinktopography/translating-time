class Observation < ActiveRecord::Base

  # attr_accessible :citation_id, :event_id, :species_id, :method_id, :user_id, :value, :is_active

  belongs_to :citation
  belongs_to :event
  belongs_to :method, :class_name => 'Methodd'
  belongs_to :species
  belongs_to :user

  validates_presence_of :event_id, :species_id, :citation_id, :method_id, :value
  validates_uniqueness_of :species_id, :scope => [:event_id, :user_id], :message => 'You have already created an observation for this species and event'
  validates_uniqueness_of :event_id, :scope => [:species_id, :user_id], :message => 'You have already created an observation for this species and event'
  
  scope :active, -> { where(:is_active => 1) }

  def self.collect
    species = Species.unscoped.in_model.order("id ASC").all
    events = Event.unscoped.in_model.order("id ASC").all
    grid = {}
    Observation.active.each do |observation|
      grid[observation.species_id] = {} if grid[observation.species_id].blank?
      grid[observation.species_id][observation.event_id] = observation
    end
    grid
  end

  def self.export
    species = Species.unscoped.in_model.order("id ASC").all
    events = Event.unscoped.in_model.order("id ASC").all
    grid = {}
    Observation.active.each do |observation|
      grid[observation.species_id] = {} if grid[observation.species_id].blank?
      grid[observation.species_id][observation.event_id] = observation
    end
    assigns = { :species => species, :events => events, :grid => grid}
    view = ActionView::Base.new(ActionController::Base.view_paths, assigns)
    view.extend ApplicationHelper
    view.render(:template => 'admin/exports/observations')
  end

end
