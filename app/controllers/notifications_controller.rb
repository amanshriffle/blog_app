class NotificationsController < ApplicationController
  skip_around_action :check_profile

  def index
    @notifications = current_user.notifications
    render layout: "card_for_list"
  end

  def destroy
    notification = current_user.notifications.find(params[:id])
    notification.destroy

    redirect_to notifications_path
  end
end
