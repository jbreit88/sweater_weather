require 'rails_helper'

RSpec.describe MapQuestGeocodingFacade, type: :facade do
  describe 'class methods' do
    describe 'search_location_by_city' do
      it 'returns a single location object' do
        search = 'Denver,CO'
        location = MapQuestGeocodingFacade.search_location_by_city(search)

        expect(location).to be_a Location
      end
    end

    describe 'get_route' do
      describe 'happy path' do
        it 'returns a route object with traveltime/origin/destination' do
          route = MapQuestGeocodingFacade.get_route('denver,co', 'pueblo,co')

          expect(route).to be_a Route
          expect(route.travel_time).to_not be_nil
          expect(route.travel_time).to_not eq('Impossible route')
          expect(route.origin).to_not be_nil
          expect(route.destination).to_not be_nil
        end
      end

      describe 'sad path' do
        it 'returns a route object with impossible route when route is impossible' do
          route = MapQuestGeocodingFacade.get_route('london,uk', 'pueblo,co')

          expect(route).to be_a Route
          expect(route.travel_time).to eq('Impossible route')
          expect(route.origin).to be_nil
          expect(route.destination).to be_nil
        end
      end
    end
  end
end
