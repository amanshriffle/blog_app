class NotificationsController < ApplicationController
  before_action :user_notifications

  def index
    render json: @notifications
  end

  def show
    refer_to = @notification.refer_to
    redirect_to refer_to
  end

  def destroy
    @notification.destroy
    redirect_to "/notifications?user_id=#{params[:user_id]}"
  end

  private

  def user_notifications
    @user = User.find params[:user_id]
    @notifications = @user.notifications
    @notification = @notifications.find params[:id] unless params[:id].nil?
  end
end
