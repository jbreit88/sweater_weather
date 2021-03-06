class Api::V1::UsersController < ApplicationController

  def create
    new_user = User.create!(user_params)

    # new_user.api_keys.create!(token: SecureRandom.hex)
    new_user.update!(api_key: SecureRandom.hex)

    render json: UserSerializer.format_user(new_user), status: 201
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

end
