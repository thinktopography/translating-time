class Page < ActiveRecord::Base

  # attr_accessible :title, :permalink, :is_published, :body, :meta_keywords, :meta_description, :delete_asset
  attr_accessor :delete_asset
      
  validates_presence_of :title, :permalink
  validates_uniqueness_of :permalink
  
  scope :published, -> { where('is_published=1') }
  
  def publish
    self.is_published = 1
    self.save
  end
  
  def unpublish
    self.is_published = 0
    self.save
  end

  def to_param
    self.permalink
  end
  
  def commit(commit)
    if(commit == 'Publish')
      self.is_published = 1
    elsif(commit == 'Unpublish')
      self.is_published = 0
    end
  end

end