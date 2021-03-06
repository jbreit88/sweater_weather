class Api::V1::SessionsController < ApplicationController

  def create
    if params[:email] && params[:password]
      user = User.find_by(email: params[:email])

      if user && user.authenticate(params[:password])
        session[:user_id] = user.id

        render json: UserSerializer.format_user(user), status: 200
      else
        render_error_404('Email and Password do not match')
      end
    else
      render_error_400('Missing field')
    end
  end

end
