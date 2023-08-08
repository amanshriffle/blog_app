class AddForeignKeyToBlogsLikesComments < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :blogs, :users, column: :user_id
    add_foreign_key :likes, :users, column: :user_id
    add_foreign_key :comments, :users, column: :user_id
  end
end
