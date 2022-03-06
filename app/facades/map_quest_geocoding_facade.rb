class MapQuestGeocodingFacade

  def self.search_location_by_city(search)
    data = MapQuestGeocodingService.search_location_by_city(search)
    Location.new(data[:results][0])
  end

end
