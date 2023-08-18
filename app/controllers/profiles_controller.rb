class ProfilesController < ApplicationController
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
    unless @current_user.profile.update(profile_params)
      render json: @current_user.errors, status: 422
    end
  end
end
