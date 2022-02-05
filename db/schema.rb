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

ActiveRecord::Schema.define(version: 2022_02_02_061725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feeds", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "log_feeds", force: :cascade do |t|
    t.integer "count"
    t.bigint "feed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "log_id"
    t.index ["feed_id"], name: "index_log_feeds_on_feed_id"
    t.index ["log_id"], name: "index_log_feeds_on_log_id"
  end

  create_table "logs", force: :cascade do |t|
    t.text "remark"
    t.integer "condition"
    t.integer "shit"
    t.boolean "bath", default: false, null: false
    t.boolean "handling", default: false, null: false
    t.boolean "creaning", default: false, null: false
    t.integer "sheding"
    t.float "weight"
    t.float "length"
    t.float "temperature"
    t.float "humidity"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "reptile_id", null: false
    t.json "images"
    t.index ["reptile_id"], name: "index_logs_on_reptile_id"
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "reptiles", force: :cascade do |t|
    t.string "name", null: false
    t.string "morph"
    t.integer "sex"
    t.date "birthday"
    t.date "adoptaversary"
    t.string "image"
    t.text "comment"
    t.integer "age"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_reptiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "name"
    t.text "comment"
    t.string "avatar"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "log_feeds", "feeds"
  add_foreign_key "log_feeds", "logs"
  add_foreign_key "logs", "reptiles"
  add_foreign_key "logs", "users"
  add_foreign_key "reptiles", "users"
end
