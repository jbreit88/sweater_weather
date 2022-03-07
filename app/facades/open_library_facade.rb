class OpenLibraryFacade

  def self.search_books_by_keyword(search)
    books_data = OpenLibraryService.search_books_by_keyword(search)
    # require "pry"; binding.pry
    return_value = {
      total_results: books_data[:numFound],
      books:
        books_data[:docs].map do |data|
          Book.new(data)
        end
    }
  end

end
