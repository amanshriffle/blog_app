class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :profile_picture

  validates :user_id, uniqueness: true
  validates :first_name, :last_name, format: { with: /\A[a-zA-Z]{3,15}\z/ }
  validates :date_of_birth, presence: true, comparison: { less_than_or_equal_to: Date.today - 18.year, message: "should be 18+ years old" }
  validate :acceptable_image

  before_update :format_details

  private

  def acceptable_image
    return unless profile_picture.attached?

    if profile_picture.blob.byte_size >= 200.kilobytes
      errors.add(:profile_picture, "size must be less than 200kb.")
    end

    acceptable_types = ["image/jpeg", "image/png"]

    unless acceptable_types.include?(profile_picture.content_type)
      errors.add(:profile_picture, "must be a JPEG or PNG")
    end
  end

  def format_details
    self.first_name = first_name.capitalize
    self.last_name = last_name.capitalize
  end
end
