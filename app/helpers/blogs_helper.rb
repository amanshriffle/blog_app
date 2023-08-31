module BlogsHelper
  def find_profile_for(obj)
    obj.user.profile
  end

  def blog_profile_picture_url(obj)
    profile_picture = find_profile_for(obj).profile_picture

    if profile_picture.attached?
      "http://127.0.0.1:3000" + rails_blob_path(profile_picture, host: "localhost:3000")
    else
      return "https://png.pngtree.com/png-vector/20220520/ourmid/pngtree-man-profile-person-silhouette-user-isolated-vector-illustration-png-image_4672200.png"
    end
  end

  def blog_full_name(obj)
    profile = find_profile_for(obj)
    return profile.first_name + " " + profile.last_name
  end
end
