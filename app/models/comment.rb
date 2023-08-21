class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :blog, counter_cache: true
  has_many :replies, class_name: "Comment", foreign_key: "parent_comment_id", dependent: :destroy
  belongs_to :parent_comment, class_name: "Comment", optional: true

  validates :comment_text, presence: true, length: { in: 1..100 }

  before_save do
    self.comment_text = comment_text.capitalize
  end
  #after_create :notify_user

  private

  # def notify_user
  #   if parent_comment_id == nil
  #     blog = Blog.find(blog_id)
  #     Notification.create(
  #       notification_text: "#{User.find(user_id).username} commented on your post (#{blog.title}).",
  #       refer_to_id: blog.id,
  #       refer_to_type: "Blog",
  #       user_id: blog.user_id,
  #     )
  #   else
  #     p_comment = Comment.find(parent_comment_id)
  #     Notification.create(
  #       notification_text: "#{User.find(user_id).username} replied on your comment. (#{p_comment.comment_text}).",
  #       refer_to_id: p_comment.id,
  #       refer_to_type: "Comment",
  #       user_id: p_comment.user_id,
  #     )
  #   end
  # end
end
