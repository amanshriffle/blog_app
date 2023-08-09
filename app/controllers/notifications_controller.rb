class NotificationsController < ApplicationController
  def index
    @user = User.find params[:user_id]
    @notifications = @user.notifications

    render json: @notifications
  end

  def show
    @user = User.find params[:user_id]
    @notifications = @user.notifications.find params[:id]

    render json: @notifications.refer_to
  end

  def destroy
    @user = User.find params[:user_id]
    @notifications = @user.notifications.find params[:id]

    @notifications.destroy
  end
end
