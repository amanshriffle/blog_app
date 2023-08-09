class NotificationsController < ApplicationController
  def index
    @user = User.find params[:user_id]
    @notificaitons = @user.notifications

    render json: @notificaitons
  end

  def show
    @user = User.find params[:user_id]
    @notificaitons = @user.notifications.find params[:id]

    render json: @notificaitons.refer_to
  end

  def destroy
    @user = User.find params[:user_id]
    @notificaitons = @user.notifications.find params[:id]

    @notifications.destroy

    render :index
  end
end
