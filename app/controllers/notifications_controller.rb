class NotificationsController < ApplicationController
  #before_action :set_notifications

  def index
    render json: @current_user.notifications
  end

  def destroy
    notifications = @current_user.notifications
    notification = notifications.find(params[:id]).destroy

    render json: notifications
  end
end
