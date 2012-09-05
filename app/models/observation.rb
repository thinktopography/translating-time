class Observation < ActiveRecord::Base

  attr_accessible :citation_id, :event_id, :species_id, :method_id, :user_id, :value

  belongs_to :citation
  belongs_to :event
  belongs_to :method, :class_name => 'Methodd'
  belongs_to :species
  belongs_to :user

  validates_presence_of :event_id, :species_id, :citation_id, :method_id, :value
  validates_uniqueness_of :species_id, :scope => [:event_id, :user_id], :message => 'You have already created an observation for this species and event'
  validates_uniqueness_of :event_id, :scope => [:species_id, :user_id], :message => 'You have already created an observation for this species and event'
  
  before_create :set_activity
  
  scope :active, where(:is_active => 1)
  
  private
  
    def set_activity
      if Observation.where(:species_id => species_id, :event_id => event_id).empty?
        self.is_active = true
      end
    end
    

end
