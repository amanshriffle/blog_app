class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :blog, counter_cache: true
  has_many :replies, class_name: "Comment", foreign_key: "parent_comment_id", dependent: :destroy
  belongs_to :parent_comment, class_name: "Comment", optional: true

  validates :comment_text, presence: true, length: { in: 1..100 }

  before_save do
    self.comment_text = comment_text.capitalize
  end
end
