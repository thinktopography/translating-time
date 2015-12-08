class Import
  
  def initialize(dataset, data, attribute)
    @attribute = attribute
    @data = data
    @dataset = dataset
    @parsed = []
    @sorted = {}
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
    line.split(",")
  end

  def sort_data
    specieses = []
    @parsed[0].shift
    @parsed[0].each do |item|
      code = item.to_i
      species = Species.find_by_code(code)
      specieses << species.id
    end
    @parsed.shift
    @parsed.each do |row|
      code = row.shift.to_i
      event = Event.find_by_code(code)
      unless event.nil?
        event_id = event.id
        i = 0
        @sorted[event_id] = {}
        row.each do |value|
          species_id = specieses[i]
          @sorted[event_id][species_id] = value.to_f
          i = i + 1
        end
      end
    end
  end
  
  def estimate(species_id, event_id)
    estimate
  end
  
  def insert_data
    @sorted.each do |event_id, values|
      values.each do |species_id, value|
        estimate = Estimate.new(:dataset_id => @dataset.id, :species_id => species_id, :event_id => event_id)
        estimate.send("#{@attribute}=", value)
        estimate.save!
      end
    end
  end
      
end
