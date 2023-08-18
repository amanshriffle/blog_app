class FollowController < ApplicationController
  include NotifyUser
  before_action :set_user

  def followers
    followers = @user.followers.joins(:follower_user).select(:id, :follower_user_id, "users.username")
    render json: followers
  end

  def following
    following = @user.following.joins(:user).select(:id, :user_id, "users.username")
    render json: following
  end

  def create
    follow = @user.followers.build(follower_user_id: @current_user.id)
    if follow.save
      notify_user("#{@current_user.username} started following you.", @current_user.id, "Profile", @user.id)
      redirect_to profile_path(@user.username)
    else
      render json: follow.errors, status: :forbidden
    end
  end

  def destroy
    follow = @user.followers.find_by_follower_user_id!(@current_user.id)
    follow.destroy
    redirect_to profile_path(@user.username)
  end

  private

  def set_user
    @user = User.find_by_username!(params[:username])
  end
end
