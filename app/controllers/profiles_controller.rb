class ProfilesController < ApplicationController
  skip_around_action :check_profile, only: %i[show update]
  before_action :set_profile, except: %i[index search]

  def index
    render json: Profile.all
  end

  def show
    render json: @profile, include: { user: %i[blogs followers following] }
  end

  def update
    authorize! :update, @profile

    if @profile.update(profile_params)
      render json: @profile
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  def search
    key = "%#{params[:key]}%"
    users = Profile.joins(:user).where("users.username LIKE :key OR first_name LIKE :key OR last_name LIKE :key", { key: })

    render json: users
  end

  private

  def profile_params
    params.permit(:first_name, :last_name, :date_of_birth, :about, :profile_picture)
  end

  def set_profile
    @profile = Profile.joins(:user).find_by!('users.username': params[:username])
  end
end
