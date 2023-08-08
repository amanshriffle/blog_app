class RemoveForeignKeyFromBlogsLikesComments < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :blogs, column: :user_id
    remove_foreign_key :likes, column: :user_id
    remove_foreign_key :comments, column: :user_id
  end
end
