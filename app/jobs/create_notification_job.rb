class CreateNotificationJob < ApplicationJob
  queue_as :default

  def perform(blog)
    user = User.includes(:followers).find(blog.user_id)
    username = user.username
    followers = user.followers

    followers.each do |f|
      Notification.create(
        notification_text: "#{username} posted a new blog (#{blog.title}).",
        refer_to_id: id,
        refer_to_type: "Blog",
        user_id: f.follower_user_id,
      )
    end
  end
end
