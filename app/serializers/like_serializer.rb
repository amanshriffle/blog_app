class LikeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :username

  def username
    object.user.username
  end
end
