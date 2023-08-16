class FollowController < ApplicationController
  def followers
    followers = @current_user.followers.left_outer_joins(:follower_user).select_attr

    render json: followers
  end

  def following
    following = @current_user.following.left_outer_joins(:user).select_attr

    render json: following
  end

  def show_follower
    follow = FollowersFollowing.find(params[:id])

    redirect_to follower.follower_user
  end

  def show_following
    follow = FollowersFollowing.find(params[:id])

    redirect_to following.user
  end

  def destroy
    follow = FollowersFollowing.find(params[:id])
    follow.destroy

    redirect_to "/followings?user_id=#{params[:user_id]}"
  end

  private

  def select_attr
    self.select(:id, :follower_user_id, "users.username, users.first_name, users.last_name")
  end
end
