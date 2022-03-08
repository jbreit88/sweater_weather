require 'rails_helper'

RSpec.describe 'The Weather API', type: :request do
  describe 'index: get /api/v1/forecast' do
    describe 'happy path' do
      it 'returns a json forecast object' do
        get '/api/v1/forecast?location=Denver,CO'

        weather = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(weather).to be_a Hash
        expect(weather).to have_key(:data)

        expect(weather[:data]).to be_a Hash
        expect(weather[:data]).to have_key(:id)
        expect(weather[:data][:id]).to be_nil
        expect(weather[:data]).to have_key(:type)
        expect(weather[:data][:type]).to eq('forecast')
        expect(weather[:data]).to have_key(:attributes)

        expect(weather[:data][:attributes]).to be_a Hash
        expect(weather[:data][:attributes]).to have_key(:current_weather)
        expect(weather[:data][:attributes]).to have_key(:hourly_weather)
        expect(weather[:data][:attributes]).to have_key(:daily_weather)

        # Check that all keys are present in current_weather
        expect(weather[:data][:attributes][:current_weather]).to be_a Hash
        expect(weather[:data][:attributes][:current_weather][:data]).to be_a Hash
        expect(weather[:data][:attributes][:current_weather][:data]).to have_key(:datetime)
        expect(weather[:data][:attributes][:current_weather][:data]).to have_key(:sunrise)
        expect(weather[:data][:attributes][:current_weather][:data]).to have_key(:sunset)
        expect(weather[:data][:attributes][:current_weather][:data]).to have_key(:temp)
        expect(weather[:data][:attributes][:current_weather][:data]).to have_key(:feels_like)
        expect(weather[:data][:attributes][:current_weather][:data]).to have_key(:humidity)
        expect(weather[:data][:attributes][:current_weather][:data]).to have_key(:uvi)
        expect(weather[:data][:attributes][:current_weather][:data]).to have_key(:visibility)
        expect(weather[:data][:attributes][:current_weather][:data]).to have_key(:conditions)
        expect(weather[:data][:attributes][:current_weather][:data]).to have_key(:icon)

        # Check that datattypes are as expected in current_weather
        expect(weather[:data][:attributes][:current_weather][:data][:datetime]).to be_a String
        expect(weather[:data][:attributes][:current_weather][:data][:sunrise]).to be_a String
        expect(weather[:data][:attributes][:current_weather][:data][:sunset]).to be_a String
        expect(weather[:data][:attributes][:current_weather][:data][:temp]).to be_a Float
        expect(weather[:data][:attributes][:current_weather][:data][:feels_like]).to be_a Float
        expect(weather[:data][:attributes][:current_weather][:data][:humidity]).to be_a(Float).or be_a(Integer)
        expect(weather[:data][:attributes][:current_weather][:data][:uvi]).to be_a Float
        expect(weather[:data][:attributes][:current_weather][:data][:visibility]).to be_a(Float).or be_a(Integer)
        expect(weather[:data][:attributes][:current_weather][:data][:conditions]).to be_a String
        expect(weather[:data][:attributes][:current_weather][:data][:icon]).to be_a String

        # Check the correct number of responses are returned in hourly_weather
        expect(weather[:data][:attributes][:hourly_weather][:data].count).to eq(8)

        # Check that all keys are present in hourly_weather
        expect(weather[:data][:attributes][:hourly_weather]).to be_a Hash
        expect(weather[:data][:attributes][:hourly_weather][:data]).to be_a Array
        expect(weather[:data][:attributes][:hourly_weather][:data][0]).to have_key(:time)
        expect(weather[:data][:attributes][:hourly_weather][:data][0]).to have_key(:temp)
        expect(weather[:data][:attributes][:hourly_weather][:data][0]).to have_key(:conditions)
        expect(weather[:data][:attributes][:hourly_weather][:data][0]).to have_key(:icon)

        # Check that datattypes are as expected in hourly_weather
        expect(weather[:data][:attributes][:hourly_weather][:data][0][:time]).to be_a String
        expect(weather[:data][:attributes][:hourly_weather][:data][0][:temp]).to be_a Float
        expect(weather[:data][:attributes][:hourly_weather][:data][0][:conditions]).to be_a String
        expect(weather[:data][:attributes][:hourly_weather][:data][0][:icon]).to be_a String

        # Check the correct number of responses are returned in daily_weather
        expect(weather[:data][:attributes][:daily_weather][:data].count).to eq(5)

        # Check that all keys are present in daily_weather
        expect(weather[:data][:attributes][:daily_weather]).to be_a Hash
        expect(weather[:data][:attributes][:daily_weather][:data]).to be_a Array
        expect(weather[:data][:attributes][:daily_weather][:data][0]).to have_key(:date)
        expect(weather[:data][:attributes][:daily_weather][:data][0]).to have_key(:sunrise)
        expect(weather[:data][:attributes][:daily_weather][:data][0]).to have_key(:sunset)
        expect(weather[:data][:attributes][:daily_weather][:data][0]).to have_key(:max_temp)
        expect(weather[:data][:attributes][:daily_weather][:data][0]).to have_key(:min_temp)
        expect(weather[:data][:attributes][:daily_weather][:data][0]).to have_key(:conditions)
        expect(weather[:data][:attributes][:daily_weather][:data][0]).to have_key(:icon)

        # Check that datattypes are as expected in daily_weather
        expect(weather[:data][:attributes][:daily_weather][:data][0][:date]).to be_a String
        expect(weather[:data][:attributes][:daily_weather][:data][0][:sunrise]).to be_a String
        expect(weather[:data][:attributes][:daily_weather][:data][0][:sunset]).to be_a String
        expect(weather[:data][:attributes][:daily_weather][:data][0][:max_temp]).to be_a Float
        expect(weather[:data][:attributes][:daily_weather][:data][0][:min_temp]).to be_a Float
        expect(weather[:data][:attributes][:daily_weather][:data][0][:conditions]).to be_a String
        expect(weather[:data][:attributes][:daily_weather][:data][0][:icon]).to be_a String
      end
    end

    describe 'sad path' do
      describe 'No params sent' do
        it 'returns an error status and message' do
          get '/api/v1/forecast'

          error = JSON.parse(response.body, symbolize_names: true)

          expect(response.status).to eq(400)

          expect(error[:error][:exception]).to eq('Please provide all neccessary params.')
        end
      end
    end
  end
end
