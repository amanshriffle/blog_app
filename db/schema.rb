# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_17_130045) do
  create_table "blogs", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.boolean "visible"
    t.integer "user_id"
    t.integer "likes_count"
    t.integer "comments_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_blogs_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "comment_text"
    t.integer "blog_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_comment_id"
    t.index ["blog_id"], name: "index_comments_on_blog_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "followers_following", force: :cascade do |t|
    t.integer "user_id"
    t.integer "follower_user_id"
    t.index ["follower_user_id"], name: "index_followers_following_on_follower_user_id"
    t.index ["user_id"], name: "index_followers_following_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "blog_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.index ["blog_id"], name: "index_likes_on_blog_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "notification_text"
    t.string "refer_to_type"
    t.integer "refer_to_id"
    t.integer "user_id", null: false
    t.datetime "created_at"
    t.index ["refer_to_type", "refer_to_id"], name: "index_notifications_on_refer_to"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.string "url"
    t.string "imageable_type"
    t.integer "imageable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.date "date_of_birth"
    t.string "about"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  add_foreign_key "blogs", "users"
  add_foreign_key "comments", "blogs"
  add_foreign_key "comments", "users"
  add_foreign_key "followers_following", "users"
  add_foreign_key "likes", "blogs"
  add_foreign_key "likes", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "profiles", "users"
end
