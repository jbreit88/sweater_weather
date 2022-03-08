require 'rails_helper'

RSpec.describe 'The Users API', type: :request do
  describe 'create: post /api/v1/users' do
    describe 'happy path' do
      it 'returns a json response of created user with an API key' do
        user_params = {
          email: "whatever@example.com",
          password: "password",
          password_confirmation: "password"
        }

        headers = {"CONTENT_TYPE" => "application/json"}

        post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

        created_user = User.last

        expect(response.status).to eq(201)
        expect(created_user.email).to eq(user_params[:email])
        expect(created_user.password_digest).to_not be_nil
        expect(created_user.api_keys.count).to eq(1)
      end
    end

    describe 'sad path' do
      it 'returns error message when passwords do not match' do
        user_params = {
          email: "whatever@example.com",
          password: "password",
          password_confirmation: "wrongpassword"
        }

        headers = {"CONTENT_TYPE" => "application/json"}

        post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

        expect(response.status).to eq(400)
        expect(response.body).to match("Validation failed: Password confirmation doesn't match Password")
      end

      it 'returns error message when email is already taken' do
        user = User.create!(email: "whatever@example.com",
        password: "password",
        password_confirmation: "password")

        user_params = {
          email: "whatever@example.com",
          password: "password1",
          password_confirmation: "password1"
        }

        headers = {"CONTENT_TYPE" => "application/json"}

        post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

        expect(response.status).to eq(400)
        expect(response.body).to match('Email has already been taken')
      end
    end
  end
end
