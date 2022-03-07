require 'rails_helper'

RSpec.describe OpenLibraryFacade, type: :facade do
  describe 'class methods' do
    describe 'search_books_by_keyword' do
      it 'returns an array of books' do
        books = OpenLibraryFacade.search_books_by_keyword('denver,co')

        expect(books).to be_a Array

        books.each do |book|
          expect(book).to be_a Book
        end
      end
    end
  end
end
