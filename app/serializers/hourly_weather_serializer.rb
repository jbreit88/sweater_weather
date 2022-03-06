class HourlyWeatherSerializer
  include JSONAPI::Serializer

  attributes  :datetime,
              :temp,
              :conditions,
              :icon

  def self.format_hourly_weather(hourly_weather)
    {
      'data': hourly_weather.map do |weather|
        {
          "time": weather.datetime,
          "temp": weather.temp,
          "conditions": weather.conditions,
          "icon": weather.icon
        }
      end
    }
  end
end
