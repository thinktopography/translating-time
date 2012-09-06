class Estimate < ActiveRecord::Base

  attr_accessible :event_id, :species_id, :value

  belongs_to :event
  belongs_to :species

end