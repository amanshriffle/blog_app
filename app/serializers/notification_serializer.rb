class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :notification_text, :created_at

  belongs_to :refer_to, key: :related_to
end
