class FollowsController < ApplicationController
  include NotifyUser

  def create
    follow = @current_user.following.build(user_id: params[:user_id])

    if follow.save
      notify_user("#{@current_user.username} started following you.", @current_user.id, "User", params[:user_id])
      render json: follow, status: :created
    else
      render json: follow.errors, status: :forbidden
    end
  end

  def destroy
    follow = FollowersFollowing.find(params[:id])

    if @current_user.id == follow.user_id || @current_user.id == follow.follower_user_id
      follow.destroy
      render json: follow
    else
      render json: [error: "Unauthorized"], status: :unauthorized
    end
  end
end
