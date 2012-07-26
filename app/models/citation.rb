class Citation < ActiveRecord::Base

  # attr_accessible :title, :body
  
  has_many :observations
  
end