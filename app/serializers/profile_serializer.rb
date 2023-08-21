class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :date_of_birth, :about
  belongs_to :user
end
