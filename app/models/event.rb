class Event < ActiveRecord::Base
  
  attr_accessible :name, :code, :scale, :description, :in_model, :location_id, :process_id
  
  belongs_to :location
  belongs_to :process, :class_name => 'Proces', :foreign_key => 'process_id'
  has_many :observations

  validates_presence_of :name

end
