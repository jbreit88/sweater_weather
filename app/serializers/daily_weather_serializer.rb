class DailyWeatherSerializer
  include JSONAPI::Serializer

  def self.format_daily_weather(daily_weather)
    {
      'data': daily_weather.map do |weather|
        {
          "date": weather.datetime,
          "sunrise": weather.sunrise,
          "sunset": weather.sunset,
          "max_temp": weather.max_temp,
          "min_temp": weather.min_temp,
          "conditions": weather.conditions,
          "icon": weather.icon
        }
      end
    }
  end
end
