class Picture < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  validates :imageable_id, presence: true
end
