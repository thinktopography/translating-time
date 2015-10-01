class Proces < ActiveRecord::Base
  
  self.table_name = "processes"
  
  # attr_accessible :name, :code, :value, :description

  has_many :events

  validates_presence_of :name

end