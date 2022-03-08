class Api::V1::BookSearchController < ApplicationController

  def index
    if params[:quantity] && !params[:quantity].empty? && params[:quantity].to_i >= 1
      # Pass in city/state search to get location
      location = MapQuestGeocodingFacade.search_location_by_city(params[:location])

      # Use location lat and long to get current/hourly/daily weather report
      current_weather = OpenWeatherFacade.current_weather_by_coords(location.latitude, location.longitude)

      # Use location search to get books
      related_books = OpenLibraryFacade.search_books_by_keyword(location.city_state)
      # require "pry"; binding.pry

      # Pass in all three objects to serializer for a JSON response
      render json: BookSerializer.format_books(related_books, current_weather, location, params[:quantity])
    else
      render_error_400("Bad params")
    end
  end

end
