class NotificationsController < ApplicationController
  skip_around_action :check_profile

  def index
    render json: current_user.notifications
  end

  def destroy
    notification = current_user.notifications.find(params[:id])
    notification.destroy

    render json: notifications
  end
end
