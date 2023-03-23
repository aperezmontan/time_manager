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

ActiveRecord::Schema[7.0].define(version: 2023_03_14_230626) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "level", ["owner", "view", "edit"]
  create_enum "project_update_reason", ["out_of_office", "vacation", "funding", "contract_missing_items", "schedule_conflicts", "blocked_by_SME", "other"]
  create_enum "project_update_status", ["started", "stopped", "finished"]

  create_table "project_access_controls", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "user_id", null: false
    t.enum "level", default: "view", null: false, enum_type: "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id", "user_id"], name: "by_project_and_user", unique: true
    t.index ["project_id"], name: "index_project_access_controls_on_project_id"
    t.index ["user_id"], name: "index_project_access_controls_on_user_id"
  end

  create_table "project_updates", force: :cascade do |t|
    t.text "note"
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "reason", enum_type: "project_update_reason"
    t.datetime "manually_edited_time", default: -> { "CURRENT_TIMESTAMP" }
    t.enum "status", default: "started", enum_type: "project_update_status"
    t.index ["project_id"], name: "index_project_updates_on_project_id"
    t.index ["reason"], name: "index_project_updates_on_reason"
    t.index ["status"], name: "index_project_updates_on_status"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "project_access_controls", "projects"
  add_foreign_key "project_access_controls", "users"
  add_foreign_key "project_updates", "projects"
end
