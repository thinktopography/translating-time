class Species < ActiveRecord::Base

  attr_accessible :name, :code, :constant, :slope, :in_model

  validates_presence_of :name

end