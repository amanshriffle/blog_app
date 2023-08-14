class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :refer_to, polymorphic: true

  validates :notification_text, presence: true
end
