class Location < ActiveRecord::Base

  attr_accessible :name, :code, :value, :description
  
  has_many :events
  
  validates_presence_of :name
  
end