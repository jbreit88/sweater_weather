class Api::V1::BackgroundsController < ApplicationController

  def index
    image = UnsplashImageFacade.get_city_image(params[:location])

    render json: BackgroundSerializer.format_background(image)
  end

end
