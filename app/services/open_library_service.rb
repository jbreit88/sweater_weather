class OpenLibraryService < BackEndService

  def self.search_books_by_keyword(search)
    get_data("/search.json?q=#{search}")
  end

  private

  def self.conn
    Faraday.new(url: 'http://openlibrary.org')
  end
end
