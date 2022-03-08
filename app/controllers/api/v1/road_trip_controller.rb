class Api::V1::RoadTripController < ApplicationController
  before_action :authenticate

  def create
    route = MapQuestGeocodingFacade.get_route(params[:origin], params[:destination])

    if route.travel_time == 'Impossible route'
      render_error_400('Cannot calculate route.')
    else
      destination = MapQuestGeocodingFacade.search_location_by_city(route.destination)

      hourly_weather_at_dest = OpenWeatherFacade.hourly_weather_by_coords(destination.latitude, destination.longitude)

      render json: RoadTripSerializer.format_road_trip(route, hourly_weather_at_dest)
    end
  end

  private

  def authenticate
    api_key = params[:api_key]

    @user = User.find_by(api_key: api_key) if api_key

    unless @user
      render_error_401('You must provide a valid authentication key to access this feature.')
    end
  end
end
