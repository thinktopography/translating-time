class Translation

  attr_accessor :species_1, :species_2, :location, :process, :days, :min, :max

  include ActiveModel::Validations
  
  validates_presence_of :species_1, :species_2, :location, :process, :days
  
  def attributes=(attributes)
    attributes.each do |key, value|
      self.send("#{key}=", value) 
    end
  end
  
end