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
  end
end
