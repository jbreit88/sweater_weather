class Api::V1::ForecastController < ApplicationController
  def index
    # Pass in city/state search to get location
    location = MapQuestGeocodingFacade.search_location_by_city(params[:location])

    # Use location lat and long to get current/hourly/daily weather report
    current_weather = OpenWeatherFacade.current_weather_by_coords(location.latitude, location.longitude)

    hourly_weather = OpenWeatherFacade.hourly_weather_by_coords(location.latitude, location.longitude)

    daily_weather = OpenWeatherFacade.daily_weather_by_coords(location.latitude, location.longitude)

    # Pass in all three objects to serializers for a JSON response
    render json: {
      data: {
        id: nil,
        type: 'forecast',
        attributes: {
          current_weather: CurrentWeatherSerializer.format_current_weather(current_weather),
          hourly_weather: HourlyWeatherSerializer.format_hourly_weather(hourly_weather),
          daily_weather: DailyWeatherSerializer.format_daily_weather(daily_weather)
        }
      }
    }
  end
end
