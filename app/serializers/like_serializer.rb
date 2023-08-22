class LikeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :username

  def username
    self.object.user.username
  end
end
