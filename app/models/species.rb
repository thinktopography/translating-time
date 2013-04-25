class Species < ActiveRecord::Base

  attr_accessible :name, :scientific_name, :code, :constant, :slope, :precocial_score, :brain, :weight, :gestation, :in_model, :taxonomy_ids
    
  has_many :estimates
  has_many :observations
  has_and_belongs_to_many :taxonomies, :join_table => :classifications

  validates_presence_of :name
  
  scope :in_model, where(:in_model => true)
  default_scope order('name ASC')
  
  def name_with_min_max
    "#{self.name} - #{self.minimum} - #{self.maximum}"
  end
  
  def translate(species, location, process, days)
    event_score = (Math.log(days.to_f) - self.constant.to_f - self.interaction(location, process)) / self.slope.to_f
    Math.exp(species.constant.to_f + species.slope.to_f * event_score + species.interaction(location, process))
  end
  
  def interaction(location, process)
    if location.id == 1 && process.id == 4 && !self.taxonomy_ids.include?(1)
      0.262766
    elsif location.id == 8 && process.id == 4 && self.id == 26
      0.320453
    else
      0
    end
  end
  
  def minimum
    self.estimates.minimum(:value)
    
  end
  
  def maximum
    self.estimates.maximum(:value)
  end

end