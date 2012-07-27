class Proces < ActiveRecord::Base
  
  self.table_name = "processes"
  
  attr_accessible :name, :code, :value, :description

  validates_presence_of :name, :code, :value

end