class NotificationsController < ApplicationController
  before_action :set_notifications

  def index
    render json: @notifications
  end

  def show
    refer_to = @notification.refer_to

    if @notification.refer_to_type == "User"
      redirect_to profile_path(refer_to.username)
    else
      redirect_to refer_to
    end
  end

  def destroy
    @notification.destroy

    render json: @notifications
  end

  private

  def set_notifications
    @notifications = @current_user.notifications
    @notification = @notifications.find(params[:id]) if params[:id]
  end
end
