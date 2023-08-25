class SendEmailToFollowerUsersJob < ApplicationJob
  queue_as :default

  def perform(user, blog)
    user.follower_users.each do |fu|
      BlogMailer.with(user: user, blog: blog, follower_user: fu).new_blog_email.deliver
    end
  end
end
