class Taxonomy < ActiveRecord::Base
  
  # attr_accessible :parent_id, :name

  # acts_as_tree :order => "name"
  
  has_and_belongs_to_many :species, :join_table => :classifications

  validates_presence_of :name

  def self.roots
    self.where(:parent_id => nil)
  end

  def children
    self.class.where(:parent_id => self.id).order(:name => :asc)
  end

end