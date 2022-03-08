class MapQuestGeocodingFacade

  def self.search_location_by_city(search)
    data = MapQuestGeocodingService.search_location_by_city(search)
    Location.new(data[:results][0])
  end

  def self.get_route(origin, destination)
    data = MapQuestGeocodingService.get_route(origin, destination)

    Route.new(data)
  end

end
