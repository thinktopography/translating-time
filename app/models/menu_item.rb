class MenuItem < ActiveRecord::Base

  attr_accessible :title, :url, :target
   
  default_scope order("created_at ASC")

end