class ForecastSerializer

  def self.format_forecast(location, current_weather, hourly_weather, daily_weather, number_of_days = 5, number_of_hours = 8)

    {
      data: {
        id: nil,
        type: 'forecast',
        attributes: {
          current_weather: {
            data: {
              datetime: current_weather.datetime,
              sunrise: current_weather.sunrise,
              sunset: current_weather.sunset,
              temp: current_weather.temp,
              feels_like: current_weather.feels_like,
              humidity: current_weather.humidity,
              uvi: current_weather.uvi,
              visibility: current_weather.visibility,
              conditions: current_weather.conditions,
              icon: current_weather.icon
            }
          },
          hourly_weather: {
            data: hourly_weather.first(number_of_hours).map do |weather|
              {
                time: weather.datetime,
                temp: weather.temp,
                conditions: weather.conditions,
                icon: weather.icon
              }
            end
          },
          daily_weather:{
            data: daily_weather.first(number_of_days).map do |weather|
              {
                date: weather.datetime,
                sunrise: weather.sunrise,
                sunset: weather.sunset,
                max_temp: weather.max_temp,
                min_temp: weather.min_temp,
                conditions: weather.conditions,
                icon: weather.icon
              }
            end
          }
        }
      }
    }
  end
end
