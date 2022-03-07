class UnsplashImageFacade

  def self.get_city_image(search)
    data = UnsplashImageService.get_city_image(search)[:results][0]

    Image.new(data)
  end

end
