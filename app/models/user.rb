class User < ApplicationRecord
  has_secure_password

  has_one :profile, dependent: :destroy
  has_one :picture, as: :imageable, dependent: :destroy
  has_many :blogs, dependent: :destroy
  has_many :notifications, -> { order created_at: :desc }, dependent: :destroy
  has_many :followers, -> { select :id, :follower_user_id }, class_name: "FollowersFollowing", dependent: :destroy
  has_many :following, -> { select :id, :user_id }, class_name: "FollowersFollowing", foreign_key: :follower_user_id, dependent: :destroy, inverse_of: :follower_user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_blogs, through: :likes, source: :blog

  has_many :follower_users, through: :followers, source: :follower_user

  validates :username, uniqueness: { case_sesitive: false }, length: { in: 3..10 }, format: { with: /\A[a-zA-Z][A-Za-z0-9_]+\z/, message: "can only contain characters, digit and uderscore." }
  validates :email, uniqueness: { case_sesitive: false }, length: { in: 5..30 }, format: { with: /\A[a-z][\w\d+\-.]+@[\w\d\-]+\.[a-z]{2,3}\z/ }
  #validates :password, format: { with: /\A(?=.{6,15})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/, message: "should be min. 6 chars long and must contain atleast one alphabet, a digit and a special character." }

  before_save do
    self.username = username.downcase
    self.email = email.downcase
  end
end
