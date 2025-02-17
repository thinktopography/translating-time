class Event < ActiveRecord::Base
  
  # attr_accessible :name, :code, :scale, :description, :in_model, :location_id, :process_id, :comment
  
  belongs_to :location
  belongs_to :process, :class_name => 'Proces', :foreign_key => 'process_id'
  has_many :observations

  validates_presence_of :name

  scope :in_model, -> { where(:in_model => true) }

end
