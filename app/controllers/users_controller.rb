class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[new create]
  skip_around_action :check_profile

  def new
    @user = User.new
    render "signup"
  end

  def edit
    render layout: "card_for_form"
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user.build_profile.save(validate: false)
      UserMailer.with(user: @user).welcome_email.deliver_later
      flash[:notice] = "You have successfully signed up, please login"
      redirect_to root_path
    else
      render "signup", status: :unprocessable_entity
    end
  end

  def update
    if @current_user.update(user_params)
      redirect_to profile_path(current_user.username)
    else
      render :edit, layout: "card_for_form"
    end
  end

  def confirm_password
    render layout: "card_for_form"
  end

  def destroy
    if @current_user.authenticate(params[:password])
      current_user.destroy
      redirect_to root_path
    else
      flash[:alert] = "Password is invalid"
      redirect_to action: :confirm_password
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
