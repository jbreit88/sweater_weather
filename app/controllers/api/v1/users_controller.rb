class Api::V1::UsersController < ApplicationController

  def create
    new_user = User.create!(user_params)

    api_key = new_user.api_keys.create!(token: SecureRandom.hex)

    render json: UserSerializer.format_user(new_user), status: 201
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

end
