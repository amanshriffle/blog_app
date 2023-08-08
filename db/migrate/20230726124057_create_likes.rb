class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :blog, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :created_at
    end
  end
end
