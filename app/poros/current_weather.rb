class CurrentWeather
  attr_reader :datetime,
              :sunrise,
              :sunset,
              :temp,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon

  def initialize(data)
    @datetime   = Time.at(data[:dt])
    @sunrise    = Time.at(data[:sunrise])
    @sunset     = Time.at(data[:sunset])
    @temp       = data[:temp]
    @feels_like = data[:feels_like]
    @humidity   = data[:humidity]
    @uvi        = data[:uvi]
    @visibility = data[:visibility]
    @conditions = data[:weather][0][:description]
    @icon       = data[:weather][0][:icon]
  end
end
