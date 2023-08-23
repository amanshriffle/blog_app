class BlogSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :likes_count, :comments_count
  attribute :created_at, key: :posted_on

  belongs_to :user
  has_many :likes
  has_many :comments
end
