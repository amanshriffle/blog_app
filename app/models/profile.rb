class Profile < ApplicationRecord
  belongs_to :user

  validates :user_id, uniqueness: true
  validates :first_name, :last_name, format: { with: /\A[a-zA-Z]{3,15}\z/ }
  validates :date_of_birth, presence: true, comparison: { less_than_or_equal_to: Date.today - 18.year, message: "should be 18+ years old" }

  default_scope { joins(:user).select("users.username, profiles.*") }

  before_save :format_details

  private

  def format_details
    self.first_name = first_name.capitalize
    self.last_name = last_name.capitalize
  end
end
