module NotifyUser
  private

  def notify_user(*params)
    Notification.create(
      notification_text: params[0],
      refer_to_id: params[1],
      refer_to_type: params[2],
      user_id: params[3],
    )
  end
end
