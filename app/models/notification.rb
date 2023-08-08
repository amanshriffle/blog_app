class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :refer_to, polymorphic: true
  validates :notification_text, :refer_to_id, :refer_to_type, :user_id, presence: true
end
