class BlogSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :likes_count, :created_at

  belongs_to :user
  has_many :likes
  has_many :comments
end
