class NotificationCallback
  def after_commit(record, prompt, refer_to_id, refer_to_type, user_id)
    Notification.create(
      notification_text: prompt,
      refer_to_id: refer_to_id,
      refer_to_type: refer_to_type,
      user_id: user_id,
    )
  end
end
