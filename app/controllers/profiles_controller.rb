class ProfilesController < ApplicationController
  before_action :set_user, only: [:list_followers, :list_following]
  include ProfileParams

  def index
    render json: Profile.all
  end

  def show
    user = User.includes(:followers, :following, :blogs, :profile).find_by_username!(params[:username])
    user_profile = user.profile

    render json: [user_profile, { Blogs: user.blogs.size, Followers: user.followers.size, Following: user.following.size }]
  end

  def update
    user = User.includes(:profile).find_by_username!(params[:username])
    profile = user.profile

    raise ActiveRecord::ReadOnlyError unless @current_user.id == profile.user_id

    if profile.update(profile_params)
      render json: profile
    else
      render json: profile.errors, status: 422
    end
  end

  def list_followers
    followers = @user.followers.joins(:follower_user).select(:id, :follower_user_id, "users.username")
    render json: followers
  end

  def list_following
    following = @user.following.joins(:user).select(:id, :user_id, "users.username")
    render json: following
  end

  private

  def set_user
    if params[:username] == @current_user.username
      @user = @current_user
    else
      @user = User.find_by_username!(params[:username])
    end
  end
end
