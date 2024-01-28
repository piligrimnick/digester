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

ActiveRecord::Schema[7.1].define(version: 2024_01_28_220134) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chats", force: :cascade do |t|
    t.string "chat_id", null: false
    t.string "type", null: false
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_chats_on_chat_id", unique: true
  end

  create_table "message_counters", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "report_id"
    t.integer "value", default: 0
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "report_id", "date"], name: "index_message_counters_on_user_id_and_report_id_and_date", unique: true
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "chat_id"
    t.string "period", default: "daily", null: false
    t.datetime "message_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_reports_on_chat_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "telegam_user_id"
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.boolean "is_bot"
    t.boolean "blocked"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blocked"], name: "index_users_on_blocked"
    t.index ["telegam_user_id"], name: "index_users_on_telegam_user_id", unique: true
  end

end
