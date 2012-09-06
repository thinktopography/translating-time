class Import
  
  def initialize(data, width, padding)
    @data = data
    @width = width
    @padding = padding
    @parsed = []
    @sorted = {}
  end
  
  def process
    parse_data
    sort_data
    @sorted
  end
  
  private
    
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
      
end