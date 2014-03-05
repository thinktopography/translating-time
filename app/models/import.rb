class Import
  
  def initialize(file, attribute, width, padding)
    @attribute = attribute
    @width = width
    @padding = padding
    @data = file.read
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
    data = []
    0.step((line.length - 1), (@width + @padding)) do |x|
      from = x + 1
      to = from + @width
      data << line[from...to]
    end
    data
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
    missing = []
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
      else
        missing << code
      end
    end
    raise missing.inspect
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
        estimate.send("#{@attribute}=", value)
        estimate.save!
      end
    end
  end
      
end
