require 'rails_helper'

RSpec.describe 'The Book Search API', type: :request do
  describe 'index: get /api/v1/book-search' do
    describe 'happy path' do
      it 'returns a json object with destination/forecast/books' do
        get '/api/v1/book-search?location=Denver,CO&quantity=5'

        books = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(books).to be_a Hash
        expect(books).to have_key(:data)

        expect(books[:data]).to be_a Hash
        expect(books[:data]).to have_key(:id)
        expect(books[:data][:id]).to be_nil
        expect(books[:data]).to have_key(:type)
        expect(books[:data][:type]).to eq('books')
        expect(books[:data]).to have_key(:attributes)

        expect(books[:data][:attributes]).to be_a Hash
        expect(books[:data][:attributes]).to have_key(:destination)
        expect(books[:data][:attributes]).to have_key(:forecast)
        expect(books[:data][:attributes]).to have_key(:total_books_found)
        expect(books[:data][:attributes][:total_books_found]).to be_an Integer
        expect(books[:data][:attributes]).to have_key(:books)

        # Check that all keys are present in forecast and return correct datattypes
        expect(books[:data][:attributes][:forecast]).to be_a Hash
        expect(books[:data][:attributes][:forecast]).to have_key(:summary)
        expect(books[:data][:attributes][:forecast][:summary]).to be_a String
        expect(books[:data][:attributes][:forecast][:temperature]).to be_a String
        expect(books[:data][:attributes][:forecast][:temperature]).to match('F')

        # Check the correct number of responses are returned in books
        expect(books[:data][:attributes][:books].count).to eq(5)

        # Check that all keys are present in books and they return correct datattypes
        expect(books[:data][:attributes][:books]).to be_an Array

        books[:data][:attributes][:books].each do |book|
          expect(book).to be_a Hash

          expect(book).to have_key(:isbn)
          expect(book[:isbn]).to be_an Array
          expect(book[:isbn][0]).to be_a String

          expect(book).to have_key(:title)
          expect(book[:title]).to be_a String

          expect(book).to have_key(:publisher)
          expect(book[:publisher]).to be_an Array
          expect(book[:publisher][0]).to be_a String
        end  
      end

      it 'works with large numbers too' do
        get '/api/v1/book-search?location=Denver,CO&quantity=500000'

        books = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
      end
    end

    describe 'sad path' do
      describe 'quantity errors' do
        it 'returns a 400 message when quantity is negative' do
          get '/api/v1/book-search?location=Denver,CO&quantity=-1'

          books = JSON.parse(response.body, symbolize_names: true)

          expect(response).to have_http_status(400)
        end

        it 'returns a 400 message when quantity is zero' do
          get '/api/v1/book-search?location=Denver,CO&quantity=0'

          books = JSON.parse(response.body, symbolize_names: true)

          expect(response).to have_http_status(400)
        end

        it 'returns a 400 message when quantity is not a number' do
          get '/api/v1/book-search?location=Denver,CO&quantity=three'

          books = JSON.parse(response.body, symbolize_names: true)

          expect(response).to have_http_status(400)
        end
      end
    end
  end
end
