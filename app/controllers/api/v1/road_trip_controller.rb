class Api::V1::RoadTripController < ApplicationController

  def create
    route = MapQuestGeocodingFacade.get_route(params[:origin], params[:destination])

    destination = MapQuestGeocodingFacade.search_location_by_city(route.destination)

    hourly_weather_at_dest = OpenWeatherFacade.hourly_weather_by_coords(destination.latitude, destination.longitude)

    render json: RoadTripSerializer.format_road_trip(route, hourly_weather_at_dest)
  end

end
