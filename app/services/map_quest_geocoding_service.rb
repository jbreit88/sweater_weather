class MapQuestGeocodingService < BackEndService

  def self.search_location_by_city(search)
    get_data("/geocoding/v1/address?key=#{ENV['MAP_QUEST_CONSUMER_KEY']}&location=#{search}&maxResults=1")
  end

  def self.get_route(origin, destination)
    get_data("/directions/v2/route?key=#{ENV['MAP_QUEST_CONSUMER_KEY']}&from=#{origin}&to=#{destination}")
  end

  private

  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com')
  end
end
