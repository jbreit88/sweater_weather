require 'rails_helper'

RSpec.describe MapQuestGeocodingService, type: :service do
  describe 'class methods' do
    describe 'search_location_by_city' do
      it 'returns a response based on a city/state search query' do
        response = MapQuestGeocodingService.search_location_by_city('Denver,CO')

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

      end
    end
  end
end
