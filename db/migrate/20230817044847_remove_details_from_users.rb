class RemoveDetailsFromUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.remove :first_name, :last_name, :blogs_count
    end
  end
end
