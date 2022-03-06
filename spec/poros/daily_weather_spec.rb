require 'rails_helper'

RSpec.describe DailyWeather do
  let(:data) {
    {
      "dt": 1646593200,
      "sunrise": 1646573135,
      "sunset": 1646614624,
      "moonrise": 1646580900,
      "moonset": 1646630640,
      "moon_phase": 0.14,
      "temp": {
        "day": 24.12,
        "min": 21.07,
        "max": 26.91,
        "night": 21.07,
        "eve": 24.69,
        "morn": 23.25
      },
      "feels_like": {
        "day": 14.94,
        "night": 10.36,
        "eve": 15.44,
        "morn": 15.48
      },
      "pressure": 1020,
      "humidity": 78,
      "dew_point": 18.91,
      "wind_speed": 10.47,
      "wind_deg": 34,
      "wind_gust": 13.35,
      "weather": [
        {
          "id": 601,
          "main": "Snow",
          "description": "snow",
          "icon": "13d"
        }
      ],
      "clouds": 100,
      "pop": 1,
      "snow": 7.9,
      "uvi": 2.47
    }
  }

  let(:weather) { DailyWeather.new(data) }

  it 'exists with attributes' do
    expect(weather).to be_a DailyWeather

    expect(weather.datetime).to be_a Time
    expect(weather.datetime).to eq('2022-03-06 12:00:00 -0700')

    expect(weather.sunrise).to be_a Time
    expect(weather.sunrise).to eq('2022-03-06 06:25:35 -0700')

    expect(weather.sunset).to be_a Time
    expect(weather.sunset).to eq('2022-03-06 17:57:04 -0700')

    expect(weather.max_temp).to be_a Float
    expect(weather.max_temp).to eq(26.91)

    expect(weather.min_temp).to be_a Float
    expect(weather.min_temp).to eq(21.07)

    expect(weather.conditions).to be_a String
    expect(weather.conditions).to eq('snow')

    expect(weather.icon).to be_a String
    expect(weather.icon).to eq('13d')
  end
end
