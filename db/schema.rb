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

ActiveRecord::Schema[8.1].define(version: 2026_01_07_125628) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "child_accesses", force: :cascade do |t|
    t.bigint "child_id", null: false
    t.datetime "created_at", null: false
    t.string "role"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["child_id", "user_id"], name: "index_child_accesses_on_child_id_and_user_id", unique: true
    t.index ["child_id"], name: "index_child_accesses_on_child_id"
    t.index ["user_id"], name: "index_child_accesses_on_user_id"
  end

  create_table "children", force: :cascade do |t|
    t.date "birth_date"
    t.datetime "created_at", null: false
    t.string "gender"
    t.string "name"
    t.bigint "owner_id", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_children_on_owner_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "child_id", null: false
    t.text "comment"
    t.datetime "created_at"
    t.datetime "end_time"
    t.boolean "parent_validation"
    t.datetime "start_time"
    t.string "type"
    t.datetime "updated_at"
    t.bigint "user_id", null: false
    t.float "value_float"
    t.string "value_string"
    t.index ["child_id"], name: "index_events_on_child_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.date "birth_date"
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "nickname"
    t.string "phone_number"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "child_accesses", "children"
  add_foreign_key "child_accesses", "users"
  add_foreign_key "children", "users", column: "owner_id"
  add_foreign_key "events", "children"
  add_foreign_key "events", "users"
end
