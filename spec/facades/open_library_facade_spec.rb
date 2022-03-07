require 'rails_helper'

RSpec.describe OpenLibraryFacade, type: :facade do
  describe 'class methods' do
    describe 'search_books_by_keyword' do
      it 'returns an array of books' do
        books = OpenLibraryFacade.search_books_by_keyword('denver,co')

        expect(books).to be_a Hash
        expect(books).to have_key(:total_results)
        expect(books[:total_results]).to be_an Integer
        expect(books).to have_key(:books)
        expect(books[:books]).to be_an Array

        books[:books].each do |book|
          expect(book).to be_a Book
        end
      end
    end
  end
end
