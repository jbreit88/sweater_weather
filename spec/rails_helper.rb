# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'

require 'simplecov'
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  # Add WebMock stub requests here
  config.before(:each, :type => :feature) do
    # response = File.read('./spec/support/stubbed_api_responses/map_quest_geocoding_search_location_by_city.json')
    #
    # stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address").to_return(body: quote_response, status: 200)
  end

  config.before(:each, :type => :service) do
    # Stub MapQuest API calls
    location_response = File.read('./spec/support/stubbed_api_responses/map_quest_geocoding_search_location_by_city.json')

    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_QUEST_CONSUMER_KEY']}&location=Denver,CO&maxResults=1").to_return(body: location_response, status: 200)

    route_response_impossible = File.read('./spec/support/stubbed_api_responses/map_quest_get_route_london_to_pueblo_response.json')

    stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=london,uk&key=#{ENV['MAP_QUEST_CONSUMER_KEY']}&to=pueblo,co").to_return(body: route_response_impossible, status: 200)

    route_response_possible = File.read('./spec/support/stubbed_api_responses/map_quest_get_route_denver_to_pueblo_response.json')

    stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=denver,co&key=#{ENV['MAP_QUEST_CONSUMER_KEY']}&to=pueblo,co").to_return(body: route_response_possible, status: 200)

    # Stub Unsplash API calls
    image_response = File.read('./spec/support/stubbed_api_responses/unsplash_denver_image_search_response.json')

    stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{ENV['UNSPLASH_ACCESS_KEY']}&page=1&per_page=1&query=denver,co").to_return(body: image_response, status: 200)

    # Stub Weather Service API calls
    weather_response = File.read('./spec/support/stubbed_api_responses/weather_request_denver_co.json')

    stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['WEATHER_API_KEY']}&exclude=minutely,alerts&lat=39.7385&lon=-104.9849&units=imperial").to_return(body: weather_response, status: 200)

    stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=&exclude=minutely,alerts&lat=39.7385&lon=-104.9849&units=imperial").to_return(body: weather_response, status: 200)

    # Stub Open Library Service API calls
    books_response = File.read('./spec/support/stubbed_api_responses/open_library_book_search_denver_response.json')

    stub_request(:get, "http://openlibrary.org/search.json?q=denver,co").to_return(body: books_response, status: 200)
  end

  config.before(:each, :type => :facade) do
    # Stub MapQuest API calls
    location_response = File.read('./spec/support/stubbed_api_responses/map_quest_geocoding_search_location_by_city.json')

    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_QUEST_CONSUMER_KEY']}&location=Denver,CO&maxResults=1").to_return(body: location_response, status: 200)

    route_response_impossible = File.read('./spec/support/stubbed_api_responses/map_quest_get_route_london_to_pueblo_response.json')

    stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=london,uk&key=#{ENV['MAP_QUEST_CONSUMER_KEY']}&to=pueblo,co").to_return(body: route_response_impossible, status: 200)

    route_response_possible = File.read('./spec/support/stubbed_api_responses/map_quest_get_route_denver_to_pueblo_response.json')

    stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=denver,co&key=#{ENV['MAP_QUEST_CONSUMER_KEY']}&to=pueblo,co").to_return(body: route_response_possible, status: 200)

    # Stub Unsplash API calls
    image_response = File.read('./spec/support/stubbed_api_responses/unsplash_denver_image_search_response.json')

    stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{ENV['UNSPLASH_ACCESS_KEY']}&page=1&per_page=1&query=denver,co").to_return(body: image_response, status: 200)

    # Stub Weather Service API calls
    weather_response = File.read('./spec/support/stubbed_api_responses/weather_request_denver_co.json')

    stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['WEATHER_API_KEY']}&exclude=minutely,alerts&lat=39.7385&lon=-104.9849&units=imperial").to_return(body: weather_response, status: 200)

    stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=&exclude=minutely,alerts&lat=39.7385&lon=-104.9849&units=imperial").to_return(body: weather_response, status: 200)

    # Stub Open Library Service API calls
    books_response = File.read('./spec/support/stubbed_api_responses/open_library_book_search_denver_response.json')

    stub_request(:get, "http://openlibrary.org/search.json?q=denver,co").to_return(body: books_response, status: 200)
  end

  config.before(:each, :type => :request) do
    # Stub MapQuest API calls
    location_response = File.read('./spec/support/stubbed_api_responses/map_quest_geocoding_search_location_by_city.json')

    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_QUEST_CONSUMER_KEY']}&location=Denver,CO&maxResults=1").to_return(body: location_response, status: 200)

    location_response = File.read('./spec/support/stubbed_api_responses/map_quest_geocoding_search_location_by_city.json')

    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_QUEST_CONSUMER_KEY']}&location=Pueblo,CO&maxResults=1").to_return(body: location_response, status: 200)

    route_response_impossible = File.read('./spec/support/stubbed_api_responses/map_quest_get_route_london_to_pueblo_response.json')

    stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=London,UK&key=#{ENV['MAP_QUEST_CONSUMER_KEY']}&to=Pueblo,CO").to_return(body: route_response_impossible, status: 200)

    route_response_possible = File.read('./spec/support/stubbed_api_responses/map_quest_get_route_denver_to_pueblo_response.json')

    stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=Denver,CO&key=#{ENV['MAP_QUEST_CONSUMER_KEY']}&to=Pueblo,CO").to_return(body: route_response_possible, status: 200)

    # Stub Weather Service API calls
    weather_response = File.read('./spec/support/stubbed_api_responses/weather_request_denver_co.json')

    stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['WEATHER_API_KEY']}&exclude=minutely,alerts&lat=39.738453&lon=-104.984853&units=imperial").to_return(body: weather_response, status: 200)

    # Stub Unsplash API calls
    image_response = File.read('./spec/support/stubbed_api_responses/unsplash_denver_image_search_response.json')

    stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{ENV['UNSPLASH_ACCESS_KEY']}&page=1&per_page=1&query=denver,co").to_return(body: image_response, status: 200)

    no_results_response = File.read('./spec/support/stubbed_api_responses/unsplash_no_results_response.json')

    stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{ENV['UNSPLASH_ACCESS_KEY']}&page=1&per_page=1&query=jkubertbou").to_return(body: no_results_response, status: 200)

    # Stub Open Library Service API calls
    books_response = File.read('./spec/support/stubbed_api_responses/open_library_book_search_denver_response.json')

    stub_request(:get, "http://openlibrary.org/search.json?q=Denver,CO").to_return(body: books_response, status: 200)
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
