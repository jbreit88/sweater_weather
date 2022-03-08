require 'rails_helper'

RSpec.describe 'The Backgrounds API', type: :request do
  describe 'index: get /api/v1/backgrounds' do
    describe 'happy path' do
      it 'returns a json background image object' do
        get '/api/v1/backgrounds?location=denver,co'

        image = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(image).to be_a Hash
        expect(image).to have_key(:data)

        expect(image[:data]).to be_a Hash
        expect(image[:data]).to have_key(:type)
        expect(image[:data][:type]).to be_a String
        expect(image[:data]).to have_key(:id)
        expect(image[:data][:id]).to be_nil
        expect(image[:data]).to have_key(:attributes)

        expect(image[:data][:attributes]).to be_a Hash
        expect(image[:data][:attributes]).to have_key(:image)
        expect(image[:data][:attributes]).to have_key(:credit)

        expect(image[:data][:attributes][:image]).to be_a Hash
        expect(image[:data][:attributes][:image]).to have_key(:image_id)
        expect(image[:data][:attributes][:image][:image_id]).to be_a String
        expect(image[:data][:attributes][:image]).to have_key(:description)
        expect(image[:data][:attributes][:image][:description]).to be_a String
        expect(image[:data][:attributes][:image][:url]).to be_a String

        expect(image[:data][:attributes][:credit]).to be_a Hash
        expect(image[:data][:attributes][:credit]).to have_key(:original_website)
        expect(image[:data][:attributes][:credit]).to have_key(:photographer)
        expect(image[:data][:attributes][:credit]).to have_key(:photographer_profile)
      end
    end

    describe 'sad path' do
      it 'returns an error message when no results are returned' do
        get '/api/v1/backgrounds?location=jkubertbou'

        error = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(404)

        expect(error[:error][:exception]).to eq('Your search returned no results.')
      end

      it 'returns an error message when params are missing' do
        get '/api/v1/backgrounds?location='

        error = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(400)

        expect(error[:error][:exception]).to eq('Please provide all neccessary params.')
      end
    end
  end
end
