class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request
  skip_around_action :check_profile

  def show
    @user = User.new
    render "login"
  end

  def create
    @user = User.where(username: params[:username]).or(User.where(email: params[:username])).first

    unless @user
      flash[:notice] = "User does not exist."
      return redirect_to action: :show
    end

    if @user.authenticate(params[:password])
      generate_token
    else
      flash[:notice] = "Password is invalid"
      redirect_to action: :show
    end
  end

  def destroy
    session.delete(:token)
    @current_user = nil
    redirect_to root_url
  end

  private

  def generate_token
    token = jwt_encode(user_id: @user.id)
    session[:token] = token
    redirect_to blogs_path
  end
end
