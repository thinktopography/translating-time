class Estimate < ActiveRecord::Base

  # attr_accessible :event_id, :species_id, :value

  belongs_to :dataset
  belongs_to :event
  belongs_to :species

  scope :active, -> { joins(:dataset).where('datasets.is_active = ?', true) }

end