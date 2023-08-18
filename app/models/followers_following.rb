class FollowersFollowing < ApplicationRecord
  self.table_name = "followers_following"

  belongs_to :user
  belongs_to :follower_user, class_name: "User"

  validate :following_self?, :already_following_user?

  # after_create :notify_user

  private

  def following_self?
    if follower_user_id == user_id
      errors.add :follower_user_id, "You can not follow yourself"
    end
  end

  def already_following_user?
    unless FollowersFollowing.find_by(user_id: user_id, follower_user_id: follower_user_id) == nil
      errors.add :follower_user_id, "You are already following #{User.find(user_id).username}"
    end
  end

  # def notify_user
  #   Notification.create(
  #     notification_text: "#{User.find(follower_user_id).username} started following you.",
  #     refer_to_id: follower_user_id,
  #     refer_to_type: "User",
  #     user_id: user_id,
  #   )
  # end
end
