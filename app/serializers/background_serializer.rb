class BackgroundSerializer

  def self.format_background(image)
    {
      'data': {
        "type": "image",
        "id": nil,
        "attributes": {
          "image": {
            "image_id": image.image_id,
            "description": image.description,
            "url": image.url,
          },
          "credit": {
            "original_website": image.original_website,
            "photographer": image.photographer,
            "photographer_profile": image.photographer_profile
          }
        }
      }
    }
  end
end
