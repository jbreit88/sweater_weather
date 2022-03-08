require 'rails_helper'

RSpec.describe MapQuestGeocodingService, type: :service do
  describe 'class methods' do
    describe 'search_location_by_city' do
      it 'returns a response based on a city/state search query' do
        search = 'Denver,CO'
        response = MapQuestGeocodingService.search_location_by_city(search)

        # Check data structure
        expect(response).to be_a Hash
        expect(response[:results]).to be_an Array
        expect(response[:results][0]).to be_a Hash
        expect(response[:results][0]).to have_key(:locations)
        expect(response[:results][0][:locations]).to be_an Array
        expect(response[:results][0][:locations][0]).to be_a Hash
        expect(response[:results][0][:locations][0]).to have_key(:displayLatLng)
        expect(response[:results][0][:locations][0][:displayLatLng]).to have_key(:lat)
        expect(response[:results][0][:locations][0][:displayLatLng]).to have_key(:lng)

        # Check number of results returned
        expect(response[:results].count).to eq(1)

        # Check response datatype
        expect(response[:results][0][:locations][0][:displayLatLng][:lat]).to be_a Float
        expect(response[:results][0][:locations][0][:displayLatLng][:lng]).to be_a Float

        expect(response[:results][0][:providedLocation][:location]).to eq(search)
      end
    end

    describe 'get_route' do
      it 'returns a response based on the origin and destinations' do
        route = MapQuestGeocodingService.get_route('denver,co', 'pueblo,co')

        expect(route).to be_a Hash
        expect(route).to have_key(:route)
        expect(route[:route]).to be_a Hash
        expect(route[:route]).to have_key(:formattedTime)
        expect(route[:route]).to have_key(:locations)
        expect(route[:route][:locations]).to be_an Array

        route[:route][:locations].each do |location|
          expect(location).to have_key(:adminArea3)
          expect(location).to have_key(:adminArea5)
        end
      end

      it 'returns an impossible message if route cannot be done' do
        route = MapQuestGeocodingService.get_route('london,uk', 'pueblo,co')

        expect(route).to be_a Hash
        expect(route).to have_key(:info)
        expect(route[:info]).to be_a Hash
        expect(route[:info]).to have_key(:messages)
        expect(route[:info][:messages]).to be_a Array
        expect(route[:info][:messages][0]).to be_a String
      end
    end
  end
end
