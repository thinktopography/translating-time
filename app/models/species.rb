class Species < ActiveRecord::Base

  attr_accessible :name, :code, :constant, :slope, :in_model, :taxonomy_ids
  
  has_many :observations
  has_and_belongs_to_many :taxonomies, :join_table => :classifications

  validates_presence_of :name

end