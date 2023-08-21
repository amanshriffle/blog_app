class Like < ApplicationRecord
  belongs_to :user
  belongs_to :blog, counter_cache: true

  validate :user_already_liked?

  # after_create :notify_user

  private

  def user_already_liked?
    if Like.find_by(blog_id: blog_id, user_id: user_id)
      errors.add :user_id, "You have already liked the blog"
    end
  end

  # def notify_user
  #   blog = Blog.find(blog_id)
  #   Notification.create(
  #     notification_text: "#{User.find(user_id).username} liked on your post (#{blog.title}).",
  #     refer_to_id: blog_id,
  #     refer_to_type: "Blog",
  #     user_id: blog.user_id,
  #   )
  # end
end
