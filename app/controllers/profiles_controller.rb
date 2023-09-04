class ProfilesController < ApplicationController
  skip_around_action :check_profile, only: %i[update edit]
  around_action :check_profile, only: :show, if: :check_user
  before_action :set_profile, only: %i[edit update]
  attr_reader :profile

  def edit
    authorize! :update, profile

    render layout: "card_for_form"
  end

  def show
    @profile = Profile.completed.eager_load(user: :blogs).find_by!('users.username': params[:username])
  end

  def update
    authorize! :update, profile

    if profile.update(profile_params)
      redirect_to profile_path(profile.user.username)
    else
      render :edit, layout: "card_for_form", status: :unprocessable_entity
    end
  end

  private

  def set_profile
    @profile = Profile.joins(:user).find_by!('users.username': params[:username])
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :date_of_birth, :about, :profile_picture)
  end

  def check_user
    @current_user.id == Profile.joins(:user).find_by!("users.username" => params[:username]).user_id
  end
end
