class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :blog, counter_cache: true

  has_many :replies, class_name: "Comment", foreign_key: "replied_on_comment_id", dependent: :destroy
  belongs_to :replied_on_comment, class_name: "Comment", optional: true

  after_create :notify_user

  validates :comment, presence: true, length: { in: 1..100 }

  private

  def notify_user
    if replied_on_comment_id == nil
      blog = Blog.includes(:user).find(blog_id)
      Notification.create(
        notification_text: "#{User.find(user_id).username} commented on your post (#{blog.title}).",
        refer_to_id: blog_id,
        refer_to_type: "Blog",
        user_id: blog.user.id,
      )
    else
      parent_comment = Comment.includes(:user).find(replied_on_comment_id)
      Notification.create(
        notification_text: "#{User.find(user_id).username} replied on your comment. (#{parent_comment.comment}).",
        refer_to_id: replied_on_comment_id,
        refer_to_type: "Comment",
        user_id: parent_comment.user.id,
      )
    end
  end
end
