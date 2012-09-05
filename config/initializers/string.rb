class String
  def pad(length, char)
    output = self.to_str
    while(output.length < length)
      output = char + output
    end
    output
  end
end