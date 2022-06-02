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

ActiveRecord::Schema[7.0].define(version: 2022_04_07_142309) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "preferences", force: :cascade do |t|
    t.string "time_zone", default: "America/New_York", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_preferences_on_user_id", unique: true
  end

  create_table "result_submissions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "wordle_id", null: false
    t.text "share_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "score"
    t.index ["user_id", "wordle_id"], name: "index_result_submissions_on_user_id_and_wordle_id", unique: true
    t.index ["user_id"], name: "index_result_submissions_on_user_id"
    t.index ["wordle_id"], name: "index_result_submissions_on_wordle_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.bigint "wordle_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["wordle_id"], name: "index_rounds_on_wordle_id"
  end

  create_table "rounds_users", force: :cascade do |t|
    t.bigint "round_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["round_id"], name: "index_rounds_users_on_round_id"
    t.index ["user_id"], name: "index_rounds_users_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "login_key"
  end

  create_table "wordles", force: :cascade do |t|
    t.integer "game_number"
    t.string "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "preferences", "users"
  add_foreign_key "result_submissions", "users"
  add_foreign_key "result_submissions", "wordles"
  add_foreign_key "rounds", "wordles"
  add_foreign_key "rounds_users", "rounds"
  add_foreign_key "rounds_users", "users"
end
