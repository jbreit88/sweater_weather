require 'rails_helper'

RSpec.describe OpenWeatherService, type: :service do
  describe 'class methods' do
    describe 'get_weather_by_coords' do
      it 'returns the current, daily, and hourly weather reports for the desired coordinates' do
        response = OpenWeatherService.get_weather_by_coords(39.7385, -104.9849)
      
        expect(response).to be_a Hash
        expect(response).to have_key(:lat)
        expect(response[:lat]).to be_a Float
        expect(response[:lat]).to eq(39.7385)
        expect(response).to have_key(:lon)
        expect(response[:lon]).to be_a Float
        expect(response[:lon]).to eq(-104.9849)

        # Check that response has desired current weather information
        expect(response).to have_key(:current)
        expect(response[:current]).to be_a Hash

        expect(response[:current]).to have_key(:dt)
        expect(response[:current]).to have_key(:sunrise)
        expect(response[:current]).to have_key(:sunset)
        expect(response[:current]).to have_key(:temp)
        expect(response[:current]).to have_key(:feels_like)
        expect(response[:current]).to have_key(:humidity)
        expect(response[:current]).to have_key(:uvi)
        expect(response[:current]).to have_key(:visibility)
        expect(response[:current]).to have_key(:weather)

        # Check nested datat structure
        expect(response[:current][:weather]).to be_an Array
        expect(response[:current][:weather][0]).to be_a Hash
        expect(response[:current][:weather][0]).to have_key(:description)
        expect(response[:current][:weather][0]).to have_key(:icon)

        # Check that response has desired hourly weather
        expect(response).to have_key(:hourly)
        expect(response[:hourly]).to be_a Array

        response[:hourly].each do |weather|
          expect(weather).to have_key(:dt)
          expect(weather).to have_key(:temp)
          expect(weather).to have_key(:weather)
          expect(weather[:weather]).to be_an Array
          expect(weather[:weather][0]).to be_a Hash
          expect(weather[:weather][0]).to have_key(:description)
          expect(weather[:weather][0]).to have_key(:icon)
        end

        # Check that response has desired daily weather
        expect(response).to have_key(:daily)
        expect(response[:daily]).to be_a Array

        response[:daily].each do |weather|
          expect(weather).to have_key(:dt)
          expect(weather).to have_key(:sunrise)
          expect(weather).to have_key(:sunset)
          expect(weather).to have_key(:temp)
          expect(weather[:temp]).to be_a Hash
          expect(weather[:temp]).to have_key(:max)
          expect(weather[:temp]).to have_key(:min)
          expect(weather[:weather]).to be_an Array
          expect(weather[:weather][0]).to be_a Hash
          expect(weather[:weather][0]).to have_key(:description)
          expect(weather[:weather][0]).to have_key(:icon)
        end
      end
    end
  end
end
