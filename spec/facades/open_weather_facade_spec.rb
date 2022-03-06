require 'rails_helper'

RSpec.describe OpenWeatherFacade, type: :facade do
  describe 'class methods' do
    describe 'current_weather_by_coords' do
      it 'returns a current weather object' do
        current_weather = OpenWeatherFacade.current_weather_by_coords(39.7385, -104.9849)

        expect(current_weather).to be_a CurrentWeather
      end
    end

    describe 'hourly_weather_by_coords' do
      it 'returns an array of hourly weather objects for next 48 hours of weather' do
        hourly_weather = OpenWeatherFacade.hourly_weather_by_coords(39.7385, -104.9849)

        expect(hourly_weather.count).to eq(48)

        hourly_weather.each do |weather|
          expect(weather).to be_a HourlyWeather
        end
      end
    end

    describe 'daily_weather_by_coords' do
      it 'returns an array of daily weather objects for next 8 days of weather' do
        daily_weather = OpenWeatherFacade.daily_weather_by_coords(39.7385, -104.9849)

        expect(daily_weather.count).to eq(8)

        daily_weather.each do |weather|
          expect(weather).to be_a DailyWeather
        end
      end
    end
  end
end
