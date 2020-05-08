require 'meteoservice_forecast'

describe MeteoserviceForecast do
  describe '#to_s' do
    let(:forecast) do
      MeteoserviceForecast.new(
        date: Date.parse('30.11.2019'),
        time_of_day: 'morning',
        temperature_min: 10,
        temperature_max: 13,
        cloudiness: 'sunny',
        max_wind: 10
      )
    end

    it 'displays temperature range' do
      expect(forecast.to_s).to include('+10..+13')
    end

    it 'displays date' do
      expect(forecast.to_s).to include('30.11.2019')
    end

    it 'displays cloudiness' do
      expect(forecast.to_s).to include('sunny')
    end

    it 'displays wind speed' do
      expect(forecast.to_s).to include('wind 10 m/s')
    end
  end
end
