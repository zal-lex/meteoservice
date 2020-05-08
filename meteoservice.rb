require 'net/http'
require 'rexml/document'
require_relative 'lib/meteoservice_forecast'

# City list from meteoservice
CITIES = {
  247 => 'Paris',
  248 => 'London',
  426 => 'L.A.',
  10_105 => 'Chicago',
  270 => 'Tokyo',
  331 => 'Baghdad',
  398 => 'New York',
  37 => 'Moscow',
  10_367 => 'Memphis',
  421 => 'Cape Town',
  10_180 => 'Dallas',
  279 => 'Amsterdam',
  10_362 => 'Boston',
  282 => 'Berlin',
  427 => 'San Francisco'
}.invert.freeze

# Let's make an array of city names by taking the keys of the CITIES hash
city_names = CITIES.keys

# We ask the user which city in order he needs
puts 'What city do you want to know the weather for?'
city_names.each_with_index { |name, index| puts "#{index + 1}: #{name}" }
city_index = gets.to_i
unless city_index.between?(1, city_names.size)
  city_index = gets.to_i
  puts "Enter a number from 1 to #{city_names.size}"
end

# When we get the desired index, we get city_id
city_id = CITIES[city_names[city_index - 1]]

# Get the request address
url = "https://xml.meteoservice.ru/export/gismeteo/point/#{city_id}.xml"

# XML parsing
response = Net::HTTP.get_response(URI.parse(url))
doc = REXML::Document.new(response.body)

city_name = URI.decode_www_form(doc.root.elements['REPORT/TOWN'].attributes['sname'])

forecast_nodes = doc.root.elements['REPORT/TOWN'].elements.to_a

puts city_name
puts

forecast_nodes.each do |node|
  puts MeteoserviceForecast.from_xml(node)
  puts
end
