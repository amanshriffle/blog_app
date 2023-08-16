class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: :create

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: 422
    end
  end

  def update
    unless @current_user.update(user_params)
      render json: @current_user.errors, status: 422
    end
  end

  def destroy
    @current_user.destroy
  end

  def profile
    user = User.includes(:followers, :following).select(:id, :user_name, :first_name, :last_name).find(params[:id])
    followers_count = user.followers.count
    following_count = user.following.count

    render json: [user, { Blogs: user.blogs_count, Followers: followers_count, Following: following_count }]
  end

  private

  def user_params
    params.permit(:user_name, :first_name, :last_name, :email)
  end
end
