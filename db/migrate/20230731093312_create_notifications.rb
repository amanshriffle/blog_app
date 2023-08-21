class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :notification_text
      t.references :refer_to, polymorphic: true
      t.references :user, null: false, foreign_key: true
      t.datetime :created_at
    end
  end
end
