class CreateFollowersFollowing < ActiveRecord::Migration[7.0]
  def change
    create_table :followers_following do |t|
      t.references :user, foreign_key: true
      t.belongs_to :follower_user
    end
  end
end
