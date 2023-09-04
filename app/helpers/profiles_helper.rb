module ProfilesHelper
  def profile_picture_url(obj)
    profile_picture = obj.profile_picture

    if profile_picture.attached?
      rails_blob_path(profile_picture, host: "localhost:3000")
    else
      return "https://png.pngtree.com/png-vector/20220520/ourmid/pngtree-man-profile-person-silhouette-user-isolated-vector-illustration-png-image_4672200.png"
    end
  end

  def full_name
    return @profile.first_name + " " + @profile.last_name
  end

  def user
    @profile.user
  end

  def find_follow
    @follow = @current_user.following.find_by(user_id: user.id)
    return @follow
  end
end
