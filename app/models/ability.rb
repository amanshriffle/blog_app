# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here.
    can :read, Blog, visible: true
    can :read, Comment

    return if user.blank?
    can :manage, User, { user: }
    can :read, Profile
    can :update, Profile, { user: }
    can :read, Blog, { visible: false, user: }
    can %i[update destroy], Blog, { user: }
    can %i[update destroy], Comment, { user: }
    can :destroy, Like, { user: }
    can :destroy, FollowersFollowing, user_id: user.id
    can :destroy, FollowersFollowing, follower_user_id: user.id
  end
end
