class HourlyWeather
  attr_reader :datetime,
              :temp,
              :conditions,
              :icon

  def initialize(data)
    @datetime   = Time.at(data[:dt]).strftime('%H:%M:%S')
    @temp       = data[:temp]
    @conditions = data[:weather][0][:description]
    @icon       = data[:weather][0][:icon]
  end
end
