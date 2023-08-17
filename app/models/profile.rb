class Profile < ApplicationRecord
  belongs_to :user
  validates :first_name, :last_name, presence: true, format: { with: /\A[a-zA-Z]{3,15}\z/, message: "is not valid" }
  validates :date_of_birth, presence: true, comparison: { less_than: Date.today - 18.year, message: "user should be 18+ year old" }
end
