class CurrentWeatherSerializer

  def self.format_current_weather(current_weather)
    {
      'data': {
        "datetime": current_weather.datetime,
        "sunrise": current_weather.sunrise,
        "sunset": current_weather.sunset,
        "temp": current_weather.temp,
        "feels_like": current_weather.feels_like,
        "humidity": current_weather.humidity,
        "uvi": current_weather.uvi,
        "visibility": current_weather.visibility,
        "conditions": current_weather.conditions,
        "icon": current_weather.icon
      }
    }
  end
end
