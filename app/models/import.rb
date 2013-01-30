class Import
  
  def initialize(file)
    @data = file.read
    @width = 5
    @padding = 2
    @parsed = []
    @sorted = {}
  end
  
  def self.attribute(attribute)
    @@attribute = attribute
  end
  
  def process
    parse_data
    sort_data
    insert_data
  end
  
  def parse_data
    lines = @data.gsub(/\r\n/, "\r").gsub(/\n/, "\r").split("\r")      
    @parsed = []
    lines.each do |line|
      @parsed << parse_line(line)
    end
  end

  def parse_line(line)
    data = []
    0.step(line.length, (@width + @padding)) do |x|
      to = x + @width
      data << line[x...to]
    end
    data
  end

  def sort_data
    specieses = []
    @parsed[0].shift
    @parsed[0].each do |item|
      specieses << item.to_i
    end
    @parsed.shift
    @parsed.each do |row|
      event = row.shift.to_i
      i = 0
      @sorted[event] = {}
      row.each do |value|
        species = specieses[i]
        @sorted[event][species] = value.to_f
        i = i + 1
      end
    end
  end
  
  def estimate(species_id, event_id)
    estimate = Estimate.where(:species_id => species_id).where(:event_id => event_id).first
    if estimate.nil?
      estimate = Estimate.create(:species_id => species_id, :event_id => event_id)
    end
    estimate
  end
  
  def insert_data
    @sorted.each do |event_id, values|
      values.each do |species_id, value|
        estimate = estimate(species_id, event_id)
        estimate.send("#{@@attribute}=", value)
        estimate.save
      end
    end
  end
      
end