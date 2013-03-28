namespace :import do
  desc "Dump entire db."
  task :scales => :environment do 
    file = File.open("#{Rails.root}/test/scales.txt", "rb")
    data = file.read
    lines = data.gsub(/\r\n/, "\r").gsub(/\n/, "\r").split("\r")      
    lines.each do |line|
      fields = line.split(",")
      puts fields[0];
      event = Event.where(:code => fields[0]).first
      event.update_attributes!({:scale => fields[1]}) unless event.nil?
    end
  end
end