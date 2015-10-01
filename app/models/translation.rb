class Translation

  attr_accessor :species_1, :species_2, :location, :process, :days, :min, :max

  include ActiveModel::Validations
  
  validates_presence_of :species_1, :species_2, :location, :process, :days
  validate :date_in_range
  
  def attributes=(attributes)
    attributes.each do |key, value|
      self.send("#{key}=", value) 
    end
  end
  
  def date_in_range
    unless self.days.to_i > self.min.to_i && self.days.to_i < self.max.to_i
      errors.add(:days, 'Date is out of range!')
    end
  end
  
end