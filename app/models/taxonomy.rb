class Taxonomy < ActiveRecord::Base
  
  attr_accessible :parent_id, :name

  acts_as_tree :order => "name"

  validates_presence_of :name
  
end