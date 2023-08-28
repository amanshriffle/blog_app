class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :refer_to, polymorphic: true

  validates :notification_text, presence: true

  before_create :destroy_duplicate_notificatons

  private

  def destroy_duplicate_notificatons
    find_not = Notification.where(notification_text: notification_text)

    unless find_not.empty?
      find_not.delete_all
    end
  end
end
