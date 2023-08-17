class ProfilesController < ApplicationController
  include ProfileParams

  def index
    render json: Profile.joins(:user).select("users.username, profiles.*")
  end

  def show
    @user_profile = User.eager_load(:followers, :following, :blogs, :profile).select("users.username, profiles.*").find_by_username(params[:username])

    unless @user_profile.nil?
      render json: [@user_profile, { Blogs: @user_profile.blogs.size, Followers: @user_profile.followers.size, Following: @user_profile.following.size }]
    else
      render json: { error: "User does not exist or enter valid username" }, status: 404
    end
  end

  def update
    unless @current_user.profile.update(profile_params)
      render json: @current_user.errors, status: 422
    end
  end
end
