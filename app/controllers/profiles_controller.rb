class ProfilesController < ApplicationController
  skip_around_action :check_profile, only: %i[update edit]
  around_action :check_profile, only: :show, if: :check_user

  def index
    render json: Profile.all
  end

  def edit
    @profile = Profile.joins(:user).find_by!('users.username': params[:username])
    authorize! :update, @profile
  end

  def show
    @profile = Profile.eager_load(user: :blogs).find_by!('users.username': params[:username])
  end

  def update
    @profile = Profile.joins(:user).find_by!('users.username': params[:username])
    authorize! :update, @profile

    if @profile.update(profile_params)
      redirect_to profile_path(@profile.user.username)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def search
    key = "%#{params[:key]}%"
    users = Profile.joins(:user).where("users.username LIKE :key OR first_name LIKE :key OR last_name LIKE :key", { key: })

    render json: users
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :date_of_birth, :about, :profile_picture)
  end

  def check_user
    @current_user.id == Profile.joins(:user).find_by!("users.username" => params[:username]).user_id
  end
end
