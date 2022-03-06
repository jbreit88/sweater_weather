require 'rails_helper'

RSpec.describe CurrentWeather do
  let(:data) {
    {
      "dt": 1646585285,
      "sunrise": 1646573135,
      "sunset": 1646614624,
      "temp": 22.71,
      "feels_like": 16.16,
      "pressure": 1019,
      "humidity": 83,
      "dew_point": 18.82,
      "uvi": 1.83,
      "clouds": 100,
      "visibility": 2174,
      "wind_speed": 5.01,
      "wind_deg": 24,
      "weather": [
        {
          "id": 601,
          "main": "Snow",
          "description": "snow",
          "icon": "13d"
        }
      ],
      "snow": {
          "1h": 1.15
      }
    }
  }

  let(:weather) { CurrentWeather.new(data) }

  it 'exists with attributes' do
    expect(weather).to be_a CurrentWeather

    expect(weather.datetime).to be_a Time
    expect(weather.datetime).to eq('2022-03-06 09:48:05 -0700')

    expect(weather.sunrise).to be_a Time
    expect(weather.sunrise).to eq('2022-03-06 06:25:35 -0700')

    expect(weather.sunset).to be_a Time
    expect(weather.sunset).to eq('2022-03-06 17:57:04 -0700')

    expect(weather.temp).to be_a Float
    expect(weather.temp).to eq(22.71)

    expect(weather.feels_like).to be_a Float
    expect(weather.feels_like).to eq(16.16)

    expect(weather.humidity).to be_a(Float).or be_a(Integer)
    expect(weather.humidity).to eq(83)

    expect(weather.uvi).to be_a Float
    expect(weather.uvi).to eq(1.83)

    expect(weather.visibility).to be_a(Float).or be_a(Integer)
    expect(weather.visibility).to eq(2174)

    expect(weather.conditions).to be_a String
    expect(weather.conditions).to eq('snow')

    expect(weather.icon).to be_a String
    expect(weather.icon).to eq('13d')
  end
end
