class AddColumnToComment < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :replied_on, :integer
  end
end
