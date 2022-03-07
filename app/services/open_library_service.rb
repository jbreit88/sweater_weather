class OpenLibraryService

  def self.search_books_by_keyword(search)
    get_data("/search.json?q=#{search}")
  end

  private

  def self.conn
    Faraday.new(url: 'http://openlibrary.org')
  end

  def self.get_data(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
