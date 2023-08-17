class FollowController < ApplicationController
  def followers
    @user = User.find_by_username(params[:username])
    followers = @user.followers.joins(:follower_user).select(:id, :follower_user_id, "users.username")

    render json: followers
  end

  def following
    @user = User.find_by_username(params[:username])
    following = @user.following.joins(:user).select(:id, :user_id, "users.username")

    render json: following
  end
end
