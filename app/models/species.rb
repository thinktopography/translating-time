class Species < ActiveRecord::Base

  attr_accessible :name, :code, :constant, :slope, :in_model
  
  has_many :observations

  validates_presence_of :name

end