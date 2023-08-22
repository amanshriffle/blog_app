class Blog < ApplicationRecord
  belongs_to :user
  has_many :comments, -> { where(parent_comment_id: nil).order created_at: :desc }, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :pictures, as: :imageable, dependent: :destroy

  validates :title, uniqueness: { case_sesitive: false }, length: { in: 5..150 }
  validates :body, length: { in: 10..1000 }
  validates :visible, inclusion: [true, false]

  before_save :format_title_and_body
  after_create :notify_user

  default_scope { order created_at: :desc }
  scope :visible, -> { where visible: true }
  scope :not_visible, -> { where visible: false }

  private

  def format_title_and_body
    self.title = title.titleize
    self.body = body.capitalize
  end

  def notify_user
    user = User.includes(:followers).find(user_id)
    username = user.username
    followers = user.followers

    followers.each do |f|
      Notification.create(
        notification_text: "#{username} posted a new blog (#{title}).",
        refer_to_id: id,
        refer_to_type: "Blog",
        user_id: f.follower_user_id,
      )
    end
  end
end
