class OpenWeatherService

  def self.get_weather_by_coords(latitude, longitude, units = 'imperial')
    get_data("/data/2.5/onecall?lat=#{latitude}&lon=#{longitude}&exclude=minutely,alerts&appid=#{ENV['WEATHER_API_KEY']}&units=#{units}")
  end

  private

  def self.conn
    Faraday.new(url: 'https://api.openweathermap.org')
  end

  def self.get_data(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
