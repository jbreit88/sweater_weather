class Api::V1::BackgroundsController < ApplicationController

  def index
    if params[:location] && !params[:location].nil? && !params[:location].empty?
      # require "pry"; binding.pry
      image = UnsplashImageFacade.get_city_image(params[:location])

      if image.error == 'This is not an image'
        render_error_404('Your search returned no results.')
      else
        render json: BackgroundSerializer.format_background(image)
      end
    else
      render_error_400('Please provide all neccessary params.')
    end
  end

end
