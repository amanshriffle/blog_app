class RenameColumnsInComments < ActiveRecord::Migration[7.0]
  def change
    change_table :comments do |t|
      t.rename :replied_on, :parent_comment_id
      t.rename :comment, :comment_text
    end
  end
end
