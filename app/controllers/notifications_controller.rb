class NotificationsController < ApplicationController
  before_action :user_notifications

  def index
    render json: @notifications
  end

  def show
    refer_to = @notification.refer_to

    if @notification.refer_to_type == "User"
      redirect_to user_path(refer_to.username)
    else
      redirect_to refer_to
    end
  end

  def destroy
    @notification.destroy
    redirect_to notifications_path
  end

  private

  def user_notifications
    @notifications = @current_user.notifications
    @notification = @notifications.find(params[:id]) if params[:id]
  end
end
