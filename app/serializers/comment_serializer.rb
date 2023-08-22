class CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment_text, :user_id, :username, :created_at
  has_many :replies

  def username
    self.object.user.username
  end
end
