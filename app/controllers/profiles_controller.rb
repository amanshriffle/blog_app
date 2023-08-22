class ProfilesController < ApplicationController
  include ProfileParams
  before_action :set_user, except: :index
  before_action :check_logged_user, only: :update

  def index
    render json: Profile.all
  end

  def show
    render json: @user, include: [:profile, :blogs, :followers, :following]
  end

  def update
    profile = @user.profile

    if profile.update(profile_params)
      render json: profile
    else
      render json: profile.errors, status: 422
    end
  end

  private

  def set_user
    @user = User.find_by_username!(params[:username])
  end

  def check_logged_user
    raise ActiveRecord::ReadOnlyError unless @current_user.id == profile.user_id
  end
end
