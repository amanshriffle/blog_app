class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: :create

  include ProfileParams

  def show
    render json: @current_user, include: :profile
  end

  def create
    @user = User.new(user_params)

    if @user.save
      create_profile
    else
      render json: [@user.errors], status: 422
    end
  end

  def update
    if @current_user.update(user_params)
      redirect_to user_path
    else
      render json: @current_user.errors, status: 422
    end
  end

  def destroy
    @current_user.destroy

    redirect_to root_path
  end

  private

  def user_params
    params.permit(:username, :email, :password)
  end

  def create_profile
    profile = @user.build_profile(profile_params)

    if profile.save
      UserMailer.with(user: @user, profile: profile).welcome_email.deliver_later
      render json: profile, status: :created
    else
      @user.delete
      render json: profile.errors, status: 422
    end
  end
end
