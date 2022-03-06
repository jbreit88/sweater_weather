class Location
  attr_reader :city_state,
              :longitude,
              :latitude

  def initialize(data)
    @city_state = data[:providedLocation][:location]
    @longitude = data[:locations][0][:displayLatLng][:lng]
    @latitude = data[:locations][0][:displayLatLng][:lat]
  end
end
