require 'rails_helper'

RSpec.describe 'The Road Trip API', type: :request do
  describe 'create: post /api/v1/road_trip' do
    describe 'happy path' do
      it 'returns a json repsonse of road trip information' do
        # Create a user
        user_params = {
          email: "whatever@example.com",
          password: "password",
          password_confirmation: "password"
        }

        headers = {"CONTENT_TYPE" => "application/json"}

        post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

        created_user = User.last

        # Log user in when sessions work

        # login_params = {
        #   email: "whatever@example.com",
        #   password: "password",
        # }
        #
        # headers = {"CONTENT_TYPE" => "application/json"}
        #
        # post '/api/v1/sessions', headers: headers, params: JSON.generate(login_params)

        # Make road trip
        road_trip_params = {
          "origin": "Denver,CO",
          "destination": "Pueblo,CO",
          "api_key": created_user.api_key
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

    describe 'sad path' do
      it 'returns a 401 error message when API key is invalid' do
        # Create a user
        user_params = {
          email: "whatever@example.com",
          password: "password",
          password_confirmation: "password"
        }

        headers = {"CONTENT_TYPE" => "application/json"}

        post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

        created_user = User.last

        # Log user in when sessions work

        # login_params = {
        #   email: "whatever@example.com",
        #   password: "password",
        # }
        #
        # headers = {"CONTENT_TYPE" => "application/json"}
        #
        # post '/api/v1/sessions', headers: headers, params: JSON.generate(login_params)

        # Make road trip
        road_trip_params = {
          "origin": "Denver,CO",
          "destination": "Pueblo,CO",
          "api_key": 'Not User Api Key'
        }

        headers = {"CONTENT_TYPE" => "application/json"}

        post '/api/v1/road_trip', headers: headers, params: JSON.generate(road_trip_params)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(401)
        expect(error[:error][:exception]).to eq("You must provide a valid authentication key to access this feature.")
      end

      it 'returns a 400 error message when the route is impossible' do
        # Create a user
        user_params = {
          email: "whatever@example.com",
          password: "password",
          password_confirmation: "password"
        }

        headers = {"CONTENT_TYPE" => "application/json"}

        post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

        created_user = User.last

        # Log user in when sessions work

        # login_params = {
        #   email: "whatever@example.com",
        #   password: "password",
        # }
        #
        # headers = {"CONTENT_TYPE" => "application/json"}
        #
        # post '/api/v1/sessions', headers: headers, params: JSON.generate(login_params)

        # Make road trip
        road_trip_params = {
          "origin": "London,UK",
          "destination": "Pueblo,CO",
          "api_key": created_user.api_key
        }

        headers = {"CONTENT_TYPE" => "application/json"}

        post '/api/v1/road_trip', headers: headers, params: JSON.generate(road_trip_params)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(400)
        expect(error[:error][:exception]).to eq("Cannot calculate route.")
      end
    end
  end
end
