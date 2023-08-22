class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email

  has_one :profile
  has_many :blogs
  has_many :followers
  has_many :following
end
