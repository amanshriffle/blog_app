class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true, index: :unique, null: false
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :about
      t.datetime "updated_at"
    end
  end
end
