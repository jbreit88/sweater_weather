require 'rails_helper'

RSpec.describe UnsplashImageService, type: :service do
  describe 'class methods' do
    describe 'get_city_image' do
      it 'returns data for a single image based on search criteria' do
        response = UnsplashImageService.get_city_image('denver,co')

        expect(response).to be_a Hash
        expect(response).to have_key(:results)
        expect(response[:results]).to be_a Array
        expect(response[:results].count).to eq(1)
        expect(response[:results][0]).to be_a Hash
        expect(response[:results][0]).to have_key(:id)
        expect(response[:results][0]).to have_key(:alt_description)
        expect(response[:results][0]).to have_key(:urls)
        expect(response[:results][0][:urls]).to be_a Hash
        expect(response[:results][0][:urls]).to have_key(:full)
        expect(response[:results][0]).to have_key(:user)
        expect(response[:results][0][:user]).to be_a Hash
        expect(response[:results][0][:user]).to have_key(:name)
        expect(response[:results][0][:user]).to have_key(:links)
        expect(response[:results][0][:user][:links]).to be_a Hash
        expect(response[:results][0][:user][:links]).to have_key(:html)
      end
    end
  end
end
