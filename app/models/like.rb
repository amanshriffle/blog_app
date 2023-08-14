class Like < ApplicationRecord
  belongs_to :user
  belongs_to :blog, counter_cache: true

  validate :user_already_liked?

  after_create :notify_user

  private

  def user_already_liked?
    unless Like.find_by(blog_id: blog_id, user_id: user_id) == nil
      errors.add :user_id, "You have already liked the blog"
    end
  end

  def notify_user
    Notification.create(
      notification_text: "#{User.find(user_id).username} liked on your post (#{Blog.find(blog_id).title}).",
      refer_to_id: blog_id,
      refer_to_type: "Blog",
      user_id: Blog.find(blog_id).user.id,
    )
  end
end
