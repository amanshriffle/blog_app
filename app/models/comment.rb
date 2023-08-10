class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :blog, counter_cache: true

  has_many :replies, class_name: "Comment", foreign_key: "replied_on", dependent: :destroy
  belongs_to :replied_on, class_name: "Comment", foreign_key: "replied_on", optional: true

  after_commit :notify_user, on: :create

  validates :comment, presence: true, length: { in: 1..100 }

  private def notify_user
    if replied_on == nil
      Notification.create(
        notification_text: "#{User.find(user_id).username} commented on your post (#{Blog.find(blog_id).title}).",
        refer_to_id: blog_id,
        refer_to_type: "Blog",
        user_id: Blog.find(blog_id).user.id,
      )
    else
      Notification.create(
        notification_text: "#{User.find(user_id).username} replied on your comment (#{Comment.find(replied_on).comment}).",
        refer_to_id: replied_on,
        refer_to_type: "Comment",
        user_id: Comment.find(replied_on).user.id,
      )
    end
  end
end
