class Like < ApplicationRecord
  belongs_to :user
  belongs_to :blog, counter_cache: true

  validate :user_already_liked?

  private

  def user_already_liked?
    if Like.find_by(blog_id: blog_id, user_id: user_id)
      errors.add :user_id, "You have already liked the blog"
    end
  end
end
