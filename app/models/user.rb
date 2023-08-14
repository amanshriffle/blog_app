class User < ApplicationRecord
  has_many :blogs, -> { where visible: true; order "created_at DESC" }, dependent: :destroy
  has_one :picture, as: :imageable, dependent: :destroy

  has_many :followers, class_name: "FollowersFollowing", dependent: :destroy
  has_many :following, class_name: "FollowersFollowing", foreign_key: :follower_user_id, dependent: :destroy

  has_many :follower_users, through: :followers, source: :follower_user
  has_many :following_users, through: :following, source: :user

  has_many :likes, dependent: :destroy
  has_many :liked_blogs, through: :likes, source: :blog

  has_many :notifications, -> { order "created_at DESC" }, dependent: :destroy

  has_secure_password

  validates :username, presence: true, uniqueness: true, length: { in: 3..10 }, format: { with: /\A[a-zA-Z][A-Za-z0-9_]+\z/, message: "can only contain characters, digit and uderscore." }
  validates :first_name, :last_name, presence: true, length: { in: 3..10 }, format: { with: /\A[a-zA-Z]+\z/, message: "Please enter valid name" }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[a-z][\w\d+\-.]+@[\w\d\-]+\.[a-z]{2,3}\z/, message: "is invalid" }
end
