class Citation < ActiveRecord::Base

  attr_accessible :body, :title, :authors, :pubmed_id, :journal, :authors, :pagination, :volume, :date
  
  has_many :observations
  
  validates_presence_of :title, :body, :authors
  
  def description
    "#{self.title} - #{self.authors}"
  end
  
end