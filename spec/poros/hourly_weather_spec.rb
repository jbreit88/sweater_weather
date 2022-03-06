require 'rails_helper'

RSpec.describe HourlyWeather do
  let(:data) {
    {
      "dt": 1646582400,
      "temp": 23.04,
      "feels_like": 14.16,
      "pressure": 1020,
      "humidity": 82,
      "dew_point": 18.9,
      "uvi": 1.08,
      "clouds": 100,
      "visibility": 1039,
      "wind_speed": 7.7,
      "wind_deg": 44,
      "wind_gust": 7.99,
      "weather": [
        {
          "id": 600,
          "main": "Snow",
          "description": "light snow",
          "icon": "13d"
        }
      ],
      "pop": 0.75,
      "snow": {
        "1h": 0.13
      }
    }
  }

  let(:weather) { HourlyWeather.new(data) }

  it 'exists with attributes' do
    Time.zone = 'Mountain Time (US & Canada)'
    
    expect(weather).to be_a HourlyWeather

    expect(weather.datetime).to be_a String
    expect(weather.datetime).to eq('09:00:00')

    expect(weather.temp).to be_a Float
    expect(weather.temp).to eq(23.04)

    expect(weather.conditions).to be_a String
    expect(weather.conditions).to eq('light snow')

    expect(weather.icon).to be_a String
    expect(weather.icon).to eq('13d')
  end
end
