module BlogsHelper
  def writer_full_name(obj)
    profile = obj.user.profile
    return profile.first_name + " " + profile.last_name
  end
end
