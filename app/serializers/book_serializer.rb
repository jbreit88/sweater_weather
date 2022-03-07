class BookSerializer

  def self.format_books(books, forecast, location, quantity)

    {
      data: {
        id: nil,
        type: 'books',
        attributes: {
          destination: location.city_state,
          forecast: {
            summary: forecast.conditions,
            temperature: "#{forecast.temp} F"
          },
          total_books_found: books.count,
          books: books.first(quantity.to_i).map do |book|
            {
              isbn: book.isbn,
              title: book.title,
              publisher: book.publisher
            }
          end
        }
      }
    }
  end


end
