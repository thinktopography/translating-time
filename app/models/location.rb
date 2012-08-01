class Location < ActiveRecord::Base

  attr_accessible :name, :code, :value, :description
  
  validates_presence_of :name
  
end