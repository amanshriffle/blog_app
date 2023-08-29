class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request
  skip_around_action :check_profile

  def new
    @user = User.new
    render "login"
  end

  def login
    user = User.where(username: params[:username]).or(User.where(email: params[:username])).first

    unless user
      flash[:notice] = "User does not exist."
      redirect_to action: :new
      return
    end

    if user.authenticate(params[:password])
      token = jwt_encode(user_id: user.id)
      session[:token] = token
      redirect_to root_path
    else
      flash[:notice] = "Password is invalid"
      redirect_to action: :new
    end
  end

  def logout
    session.delete(:token)
    @_current_user = nil
    redirect_to root_url
  end
end
