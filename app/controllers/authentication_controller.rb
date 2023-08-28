class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request
  skip_around_action :check_profile

  def login
    user = User.where(username: params[:username]).or(User.where(email: params[:username])).first

    return render json: { error: "User doesn't exist, please register first" }, status: :unauthorized unless user

    if user.authenticate(params[:password])
      token = jwt_encode(user_id: user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: "Password is invalid" }, status: :unauthorized
    end
  end
end
