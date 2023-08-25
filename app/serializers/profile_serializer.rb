class ProfileSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :user_id, :profile_picture_url, :first_name, :last_name, :date_of_birth, :about
  belongs_to :user

  def profile_picture_url
    profile_picture = object.profile_picture

    if profile_picture.attached?
      "http://127.0.0.1:3000" + rails_blob_path(profile_picture, host: "localhost:3000")
    else
      return nil
    end
  end
end
