class ProfilesController < ApplicationController
  skip_around_action :check_profile, only: :update
  before_action :set_profile, except: :index
  before_action :check_logged_user, only: :update

  def index
    render json: Profile.all
  end

  def show
    render json: @profile, include: { user: [:blogs, :followers, :following] }
  end

  def update
    @profile.profile_picture.attach(params[:profile_picture]) unless params[:profile_picture]

    if @profile.update(profile_params)
      render json: @profile
    else
      render json: @profile.errors, status: 422
    end
  end

  private

  def profile_params
    params.permit(:first_name, :last_name, :date_of_birth, :about, :profile_picture)
  end

  def set_profile
    @profile = Profile.joins(:user).find_by!('users.username': params[:username])
  end

  def check_logged_user
    raise ActiveRecord::ReadOnlyError unless @current_user.id == @profile.user_id
  end
end
