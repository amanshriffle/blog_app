module FollowsHelper
  def follow_profile_picture_url(user)
    profile_picture = user.profile.profile_picture

    if profile_picture.attached?
      "http://127.0.0.1:3000" + rails_blob_path(profile_picture, host: "localhost:3000")
    else
      return "https://png.pngtree.com/png-vector/20220520/ourmid/pngtree-man-profile-person-silhouette-user-isolated-vector-illustration-png-image_4672200.png"
    end
  end
end
