class Blog < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :comments, -> { order created_at: :desc }, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :like_by_users, through: :likes, source: :user, dependent: :destroy

  has_many :pictures, as: :imageable, dependent: :destroy

  validates :title, uniqueness: true, presence: true, length: { in: 5..100 }
  validates :body, presence: true, length: { in: 10..1000 }
  validates :visible, presence: true, inclusion: [true, false]

  after_create :notify_user

  scope :visible, -> { where visible: true }
  scope :not_visible, -> { where visible: false }

  private def notify_user
    user = User.find(user_id)
    followers = user.follower_users
    username = user.username

    followers.each do |f|
      Notification.create(
        notification_text: "#{username} posted a new blog (#{title}).",
        refer_to_id: id,
        refer_to_type: "Blog",
        user_id: f.id,
      )
    end
  end
end
