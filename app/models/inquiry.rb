class Inquiry < ActiveRecord::Base
  
  attr_accessible :name, :affiliation, :email, :comments
  
  validates_presence_of :name, :affiliation, :email, :comments
  
end