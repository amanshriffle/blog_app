class FollowController < ApplicationController
  def followers
    user = User.find(params[:user_id])
    followers = user.followers.left_outer_joins(:follower_user).select(:id, :follower_user_id, "users.username")

    render json: followers
  end

  def following
    user = User.find(params[:user_id])
    following = user.following.left_outer_joins(:user).select(:id, :user_id, "users.username")

    render json: following
  end

  def show_follower
    follower = FollowersFollowing.find(params[:id])

    redirect_to follower.follower_user
  end

  def show_following
    following = FollowersFollowing.find(params[:id])

    redirect_to following.user
  end

  def destroy
    follow = FollowersFollowing.find(params[:id])
    follow.destroy

    redirect_to "/followings?user_id=#{params[:user_id]}"
  end
end
