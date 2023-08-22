class FollowSerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :follower_user
  belongs_to :user
end
