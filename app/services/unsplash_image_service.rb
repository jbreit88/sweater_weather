class UnsplashImageService

  def self.get_city_image(search)
    get_data("/search/photos?query=#{search}&page=1&per_page=1&client_id=#{ENV['UNSPLASH_ACCESS_KEY']}")
  end

  private

  def self.conn
    Faraday.new(url: 'https://api.unsplash.com/')
  end

  def self.get_data(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

end
