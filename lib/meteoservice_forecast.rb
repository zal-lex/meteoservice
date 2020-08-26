# Connect the library for working with dates
require 'date'

# MeteoserviceForecast class - corresponding to one tag <FORECAST>
class MeteoserviceForecast
  # String arrays for time of day and cloud cover
  TIME_OF_DAY = %w[night morning afternoon evening].freeze
  CLOUDINESS = ['sunny', 'mostly sunny', 'partly cloudy', 'mostly cloudy'].freeze

  # The class constructor writes the passed parameters to the corresponding
  # class instance variables
  def initialize(params)
    @date = params[:date]
    @time_of_day = params[:time_of_day]
    @temperature_min = params[:temperature_min]
    @temperature_max = params[:temperature_max]
    @cloudiness = params[:cloudiness]
    @max_wind = params[:max_wind]
  end

  # Returns an instance of the class read from the element of the XML
  # structure with the forecast
  def self.from_xml(node)
    day = node.attributes['day']
    month = node.attributes['month']
    year = node.attributes['year']

    new(
      date: Date.parse("#{day}.#{month}.#{year}"),
      time_of_day: TIME_OF_DAY[node.attributes['tod'].to_i],
      temperature_max: node.elements['TEMPERATURE'].attributes['max'].to_i,
      temperature_min: node.elements['TEMPERATURE'].attributes['min'].to_i,
      cloudiness: CLOUDINESS[node.elements['PHENOMENA'].attributes['cloudiness'].to_i],
      max_wind: node.elements['WIND'].attributes['max'].to_i
    )
  end

  def to_s
    result = today? ? 'Today' : @date.strftime('%d.%m.%Y')

    result << ", #{@time_of_day}\n" \
      "#{temperature_range_string}, wind #{@max_wind} m/s, #{@cloudiness}"

    result
  end

  def temperature_range_string
    result = ''
    result << '+' if @temperature_min.positive?
    result << "#{@temperature_min}.."
    result << '+' if @temperature_max.positive?
    result << @temperature_max.to_s
    result
  end

  def today?
    @date == Date.today
  end
end
