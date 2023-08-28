class CreateNotificationAndSendMailJob < ApplicationJob
  queue_as :default

  def perform(blog)
    user = blog.user
    username = user.username

    user.follower_users.find_each batch_size: 100 do |f|
      Notification.create(
        notification_text: "#{username} posted a new blog (#{blog.title[0..20]}).",
        refer_to_id: blog.id,
        refer_to_type: "Blog",
        user_id: f.id,
      )
      BlogMailer.with(user: user, blog: blog, follower_user: f).new_blog_email.deliver_now
    end
  end
end
