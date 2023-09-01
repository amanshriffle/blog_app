class FollowsController < ApplicationController
  skip_around_action :check_profile, except: :create
  before_action :set_user, only: %i[list_followers list_following]
  include NotifyUser

  def create
    follow = current_user.following.build(user_id: params[:user_id])

    if follow.save
      notify_user("#{current_user.username} started following you.", current_user.id, "User", params[:user_id])
      redirect_to profile_path(follow.user.username)
    else
      redirect_to profile_path(follow.user.username), status: :forbidden
    end
  end

  def destroy
    follow = FollowersFollowing.find(params[:id])
    authorize! :destroy, follow

    follow.destroy
    #redirect_to profile_path(follow.user.username)
    render js: "window.location.reload();"
  end

  def list_followers
    @followers = @user.followers.eager_load(follower_user: :profile)
    render layout: "card_for_list"
  end

  def list_following
    @following = @user.following.eager_load(user: :profile)
    render layout: "card_for_list"
  end

  private

  def set_user
    check_param = params[:username] == current_user.username

    if check_param
      @user = current_user
    else
      @user = User.find_by!(username: params[:username])
    end
  end
end
