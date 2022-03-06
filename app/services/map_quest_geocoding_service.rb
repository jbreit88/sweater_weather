class MapQuestGeocodingService

  def self.search_location_by_city(search)
    get_data("/geocoding/v1/address?key=#{ENV['MAP_QUEST_CONSUMER_KEY']}&location=#{search}&maxResults=1")
  end

  private

  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com')
  end

  def self.get_data(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

end
