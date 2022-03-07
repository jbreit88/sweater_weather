require 'rails_helper'

RSpec.describe OpenLibraryService, type: :service do
  describe 'class methods' do
    describe 'search_books_by_keyword' do
      it 'returns data for books based on keyword search' do
        response = OpenLibraryService.search_books_by_keyword('denver,co')

        expect(response).to be_a Hash
        expect(response).to have_key(:numFound)
        expect(response).to have_key(:docs)

        expect(response[:docs]).to be_an Array

        response[:docs].first(5).each do |doc|
          expect(doc).to be_a Hash

          expect(doc).to have_key(:title)
          expect(doc[:title]).to be_a String

          expect(doc).to have_key(:publish_date)
          expect(doc[:publish_date]).to be_a Array
          expect(doc[:publish_date][0]).to be_a String

          expect(doc).to have_key(:isbn)
          expect(doc[:isbn]).to be_a Array
          expect(doc[:isbn][0]).to be_a String

          expect(doc).to have_key(:publisher)
          expect(doc[:publisher][0]).to be_a String
        end
      end
    end
  end
end
