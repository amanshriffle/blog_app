class FollowersFollowing < ApplicationRecord
  self.table_name = "followers_following"

  belongs_to :user
  belongs_to :follower_user, class_name: "User", inverse_of: :following

  validate :following_self?, :already_following_user?

  # after_create :notify_user

  private

  def following_self?
    if follower_user_id == user_id
      errors.add :follower_user_id, "You can not follow yourself."
    end
  end

  def already_following_user?
    if FollowersFollowing.find_by(user_id: user_id, follower_user_id: follower_user_id)
      errors.add :base, "You are already following."
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
