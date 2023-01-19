# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_230_114_200_840) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum 'project_update_reason', %w[blocked_by_SME other]
  create_enum 'project_update_time_status', %w[start pause hold finish]

  create_table 'project_updates', force: :cascade do |t|
    t.text 'note'
    t.bigint 'project_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.enum 'time_status', enum_type: 'project_update_time_status'
    t.enum 'reason', enum_type: 'project_update_reason'
    t.index ['project_id'], name: 'index_project_updates_on_project_id'
    t.index ['reason'], name: 'index_project_updates_on_reason'
    t.index ['time_status'], name: 'index_project_updates_on_time_status'
  end

  create_table 'projects', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'project_updates', 'projects'
end
