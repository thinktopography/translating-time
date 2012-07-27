class Event < ActiveRecord::Base
  attr_accessible :name, :code, :scale, :description, :in_model, :location_id
  
  validates_presence_of :name

end
