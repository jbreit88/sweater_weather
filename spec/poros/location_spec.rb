require 'rails_helper'

RSpec.describe Location, type: :poros do
  let(:data) {
    {
      "providedLocation": {
        "location": "Denver,CO"
      },
      "locations": [
          {
            "street": "",
            "adminArea6": "",
            "adminArea6Type": "Neighborhood",
            "adminArea5": "Denver",
            "adminArea5Type": "City",
            "adminArea4": "Denver County",
            "adminArea4Type": "County",
            "adminArea3": "CO",
            "adminArea3Type": "State",
            "adminArea1": "US",
            "adminArea1Type": "Country",
            "postalCode": "",
            "geocodeQualityCode": "A5XAX",
            "geocodeQuality": "CITY",
            "dragPoint": false,
            "sideOfStreet": "N",
            "linkId": "282041090",
            "unknownInput": "",
            "type": "s",
            "latLng": {
              "lat": 39.738453,
              "lng": -104.984853
              },
              "displayLatLng": {
                "lat": 39.738453,
                "lng": -104.984853
              },
            "mapUrl": "http://www.mapquestapi.com/staticmap/v5/map?key=MnOdRfEm4czF76XK1CSQvQSNURZbnxwj&type=map&size=225,160&locations=39.738453,-104.984853|marker-sm-50318A-1&scalebar=true&zoom=12&rand=-759130599"
          }
        ]
      }
    }

  let(:location) { Location.new(data) }

  it 'exists with attributes' do
    expect(location).to be_a Location
    expect(location.city_state).to be_a String
    expect(location.city_state).to eq('Denver,CO')
    expect(location.latitude).to be_a Float
    expect(location.latitude).to eq(39.738453)
    expect(location.longitude).to be_a Float
    expect(location.longitude).to eq(-104.984853)
  end
end
