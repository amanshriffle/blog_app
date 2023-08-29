class FollowsController < ApplicationController
  skip_around_action :check_profile, except: :create
  before_action :set_user, only: [:list_followers, :list_following]
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
    authorize! :destroy, follow

    follow.destroy
    render json: follow
  end

  def list_followers
    render json: @user.followers, each_serializer: FollowSerializer, include: :follower_user
  end

  def list_following
    render json: @user.following, each_serializer: FollowSerializer, include: :user
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
