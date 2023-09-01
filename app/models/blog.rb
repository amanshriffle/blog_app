class Blog < ApplicationRecord
  belongs_to :user
  has_many :comments, -> { where(parent_comment_id: nil).order created_at: :desc }, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many_attached :pictures

  validates :title, uniqueness: { case_sensitive: false }, length: { in: 5..150 }
  validates :body, length: { in: 10..1000 }
  validates :visible, inclusion: [true, false]

  default_scope { order created_at: :desc }
  scope :visible, -> { where visible: true }
  scope :not_visible, -> { where visible: false }

  before_save :format_title_and_body
  after_create :notify_user, if: -> { visible == true }

  private

  def format_title_and_body
    self.title = title.titleize
    self.body = body.capitalize
  end

  def notify_user
    CreateNotificationAndSendMailJob.perform_later(self)
  end
end
