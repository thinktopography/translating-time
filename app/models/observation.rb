class Observation < ActiveRecord::Base

  attr_accessible :citation_id, :event_id, :species_id, :method_id, :value

  belongs_to :citation
  belongs_to :event
  belongs_to :method, :class_name => 'Methodd'
  belongs_to :species

  validates_presence_of :event_id, :species_id, :value #:citation_id, :method_id, 

end
