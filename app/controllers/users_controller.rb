class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: :create
  skip_around_action :check_profile

  def show
    render json: current_user, include: :profile
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user.build_profile.save(validate: false)
      UserMailer.with(user: @user).welcome_email.deliver_later
      render json: @user, include: :profile, status: :created
    else
      render json: [@user.errors], status: :unprocessable_entity
    end
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.destroy

    redirect_to root_path
  end

  private

  def user_params
    params.permit(:username, :email, :password)
  end
end
