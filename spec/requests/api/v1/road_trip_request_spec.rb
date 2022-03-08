require 'rails_helper'

RSpec.describe 'The Road Trip API' do
  describe 'create: post /api/v1/road_trip' do
    describe 'happy path' do
      it 'returns a json repsonse of road trip information' do
        road_trip_params = {
          "origin": "Denver,CO",
          "destination": "Pueblo,CO",
          "api_key": "jgn983hy48thw9begh98h4539h4"
        }

        headers = {"CONTENT_TYPE" => "application/json"}

        post '/api/v1/road_trip', headers: headers, params: JSON.generate(road_trip_params)

        road_trip = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(200)

        # Check data structure
        expect(road_trip).to be_a Hash
        expect(road_trip[:data]).to be_a Hash
        expect(road_trip[:data]).to have_key(:id)
        expect(road_trip[:data]).to have_key(:type)
        expect(road_trip[:data]).to have_key(:attributes)
        expect(road_trip[:data][:attributes]).to be_a Hash
        expect(road_trip[:data][:attributes]).to have_key(:start_city)
        expect(road_trip[:data][:attributes]).to have_key(:end_city)
        expect(road_trip[:data][:attributes]).to have_key(:travel_time)
        expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)
        expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a Hash
        expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
        expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
      end
    end
  end
end
