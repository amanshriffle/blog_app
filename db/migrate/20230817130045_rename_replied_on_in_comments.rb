class RenameRepliedOnInComments < ActiveRecord::Migration[7.0]
  def change
    rename_column :comments, :replied_on, :replied_on_comment_id
  end
end
