require 'rails_helper'

RSpec.describe UnsplashImageFacade, type: :facade do
  describe 'class meethods' do
    describe 'get_city_image' do
      it 'returns a single image object' do
        image = UnsplashImageFacade.get_city_image('denver,co')

        expect(image).to be_a Image
      end
    end
  end
end
