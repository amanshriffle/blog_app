# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here.
    can :read, Blog, visible: true
    can :read, Comment

    return unless user.present?

    can :read, Profile
    can :update, Profile, user: user
    can :read, Blog, visible: false, user: user
    can [:update, :destroy], Blog, user: user
    can [:update, :destroy], Comment, user: user
    can :destroy, Like, user: user
    can :destroy, FollowersFollowing, user_id: user.id
    can :destroy, FollowersFollowing, follower_user_id: user.id
  end
end
