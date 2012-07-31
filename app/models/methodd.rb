class Methodd < ActiveRecord::Base
  
  self.table_name = "methods"
  
  attr_accessible :name
  
  validates_presence_of :name

end