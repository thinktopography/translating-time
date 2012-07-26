class Observation < ActiveRecord::Base

  # attr_accessible :title, :body

  belongs_to :citation

end
