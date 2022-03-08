require 'rails_helper'

RSpec.describe 'The Sessions API' do
  describe 'create: post /api/v1/sessions' do
    describe 'happy path' do
      it 'returns a json response of an authenticated user' do
        user = User.create!(
          email: "whatever@example.com",
          password: "password",
          password_confirmation: "password"
        )

        login_params = {
          email: "whatever@example.com",
          password: "password",
        }

        headers = {"CONTENT_TYPE" => "application/json"}

        post '/api/v1/sessions', headers: headers, params: JSON.generate(login_params)

        expect(response.status).to eq(200)
        expect(response.body).to match("whatever@example.com")
        expect(response.body).to_not match('password')
      end
    end

    describe 'sad path' do
      it 'returns a 400 level code when params are missing' do
        user = User.create!(
          email: "whatever@example.com",
          password: "password",
          password_confirmation: "password"
        )

        login_params = {
          email: "whatever@example.com"
        }

        headers = {"CONTENT_TYPE" => "application/json"}

        post '/api/v1/sessions', headers: headers, params: JSON.generate(login_params)

        expect(response.status).to eq(400)
        expect(response.body).to match('Missing field')
      end

      it 'returns a 400 level code when credentials are bad' do
        user = User.create!(
          email: "whatever@example.com",
          password: "password",
          password_confirmation: "password"
        )

        login_params = {
          email: "whatever@example.com",
          password: 'passnotword'
        }

        headers = {"CONTENT_TYPE" => "application/json"}

        post '/api/v1/sessions', headers: headers, params: JSON.generate(login_params)

        expect(response.status).to eq(400)
        expect(response.body).to match('Email and Password do not match')
      end
    end
  end
end
