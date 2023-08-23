class CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment_text, :blog_id, :created_at

  belongs_to :user
  has_many :replies
end
