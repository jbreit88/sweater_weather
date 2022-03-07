class OpenLibraryFacade

  def self.search_books_by_keyword(search)
    books_data = OpenLibraryService.search_books_by_keyword(search)[:docs]

    books_data.map do |data|
      Book.new(data)
    end
  end

end
