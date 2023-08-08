class CreateBlogs < ActiveRecord::Migration[7.0]
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :body
      t.boolean :visible
      t.references :user, foreign_key: true
      t.integer :likes_count
      t.integer :comments_count
      t.timestamps
    end
  end
end
