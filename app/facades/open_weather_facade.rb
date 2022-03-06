class OpenWeatherFacade

  def self.current_weather_by_coords(latitude, longitude)
    data = OpenWeatherService.get_weather_by_coords(latitude, longitude)[:current]

    CurrentWeather.new(data)
  end

  def self.daily_weather_by_coords(latitude, longitude)
    daily_weather_data = OpenWeatherService.get_weather_by_coords(latitude, longitude)[:daily]

    daily_weather_data.map do |data|
      DailyWeather.new(data)
    end
  end

  def self.hourly_weather_by_coords(latitude, longitude)
    hourly_weather_data = OpenWeatherService.get_weather_by_coords(latitude, longitude)[:hourly]

    hourly_weather_data.map do |data|
      HourlyWeather.new(data)
    end
  end
end
