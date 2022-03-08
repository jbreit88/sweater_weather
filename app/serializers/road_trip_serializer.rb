class RoadTripSerializer

  def self.format_road_trip(route, hourly_weather)
    if route.travel_time == 'Impossible route'

      {
        data: {
          id: nil,
          type: 'roadtrip',
          attributes: {
            start_city: nil,
            end_city: nil,
            travel_time: 'Impossible',
            weather_at_eta: {
              temperature: nil,
              conditions: nil
            }
          }
        }
      }

    else
      travel_time_array = route.travel_time.split(':')

      if travel_time_array[1].to_i + 30 > 60
        eta_weather = travel_time_array[0].to_i + 1
      else
        eta_weather = travel_time_array[0].to_i
      end

      weather_at_dest = hourly_weather.slice(eta_weather)

      {
        data: {
          id: nil,
          type: 'roadtrip',
          attributes: {
            start_city: route.origin,
            end_city: route.destination,
            travel_time: "#{travel_time_array[0]} hours, #{travel_time_array[1]} minutes",
            weather_at_eta: {
              temperature: weather_at_dest.temp,
              conditions: weather_at_dest.conditions
            }
          }
        }
      }
    end
  end

end
