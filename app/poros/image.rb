class Image
  attr_reader :original_website,
              :image_id,
              :description,
              :url,
              :photographer,
              :photographer_profile

  def initialize(data)
    @original_website = 'https://unsplash.com'
    @image_id = data[:id]
    @description = data[:alt_description]
    @url = data[:urls][:full]
    @photographer = data[:user][:name]
    @photographer_profile = data[:user][:links][:html]
  end
end
