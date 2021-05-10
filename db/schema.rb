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

ActiveRecord::Schema.define(version: 2021_04_24_150109) do

  create_table "achievements", charset: "utf8", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.bigint "employee_id"
    t.bigint "reward_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id", "reward_id"], name: "index_achievements_on_employee_id_and_reward_id"
    t.index ["employee_id"], name: "index_achievements_on_employee_id"
    t.index ["reward_id"], name: "index_achievements_on_reward_id"
    t.index ["uuid"], name: "index_achievements_on_uuid"
  end

  create_table "active_storage_attachments", charset: "utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activities", charset: "utf8", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.bigint "employee_id"
    t.bigint "event_id"
    t.bigint "sender_id"
    t.integer "value", default: 0
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_activities_on_employee_id"
    t.index ["event_id"], name: "index_activities_on_event_id"
    t.index ["sender_id"], name: "index_activities_on_sender_id"
    t.index ["uuid"], name: "index_activities_on_uuid"
  end

  create_table "companies", charset: "utf8", force: :cascade do |t|
    t.bigint "language_id"
    t.string "uuid", limit: 36, null: false
    t.string "name"
    t.string "email"
    t.string "slug"
    t.string "vat_number"
    t.string "address"
    t.string "postal_code"
    t.string "city"
    t.string "country"
    t.integer "date_format", default: 1
    t.string "timezone"
    t.integer "frequency"
    t.integer "weekday"
    t.string "hour"
    t.datetime "next_request_at"
    t.integer "hms", default: 0
    t.integer "involvement", default: 0
    t.integer "results_good", default: 0
    t.integer "results_bad", default: 0
    t.integer "results_fine", default: 0
    t.integer "high5_total", default: 0
    t.integer "feedback_given", default: 0
    t.integer "comments", default: 0
    t.boolean "help_emails", default: true
    t.string "slack_token"
    t.string "slack_team_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["language_id"], name: "index_companies_on_language_id"
    t.index ["slug"], name: "index_companies_on_slug"
    t.index ["uuid"], name: "index_companies_on_uuid"
  end

  create_table "conditions", charset: "utf8", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.bigint "rule_id"
    t.bigint "event_id"
    t.integer "operation"
    t.integer "expression"
    t.integer "value"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_conditions_on_event_id"
    t.index ["rule_id"], name: "index_conditions_on_rule_id"
    t.index ["uuid"], name: "index_conditions_on_uuid"
  end

  create_table "employees", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "language_id"
    t.bigint "company_id"
    t.bigint "team_id"
    t.string "uuid", limit: 36, null: false
    t.string "name"
    t.string "email"
    t.string "slack_username"
    t.string "api_key", limit: 36
    t.string "push_key"
    t.string "external_id"
    t.integer "hms", default: 0
    t.integer "involvement", default: 0
    t.integer "results_good", default: 0
    t.integer "results_bad", default: 0
    t.integer "results_fine", default: 0
    t.integer "high5_received", default: 0
    t.integer "high5_given", default: 0
    t.integer "feedback_given", default: 0
    t.integer "comments", default: 0
    t.integer "points", default: 0
    t.integer "role", default: 0, null: false
    t.string "level_name"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["api_key"], name: "index_employees_on_api_key", unique: true
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["email"], name: "index_employees_on_email"
    t.index ["external_id"], name: "index_employees_on_external_id"
    t.index ["language_id"], name: "index_employees_on_language_id"
    t.index ["name"], name: "index_employees_on_name"
    t.index ["team_id"], name: "index_employees_on_team_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
    t.index ["uuid"], name: "index_employees_on_uuid"
  end

  create_table "events", charset: "utf8", force: :cascade do |t|
    t.bigint "company_id"
    t.string "uuid", limit: 36, null: false
    t.string "name", limit: 50, null: false
    t.integer "category", default: 0
    t.string "image_path"
    t.text "description"
    t.string "activity_description"
    t.integer "value", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category"], name: "index_events_on_category"
    t.index ["company_id"], name: "index_events_on_company_id"
    t.index ["uuid"], name: "index_events_on_uuid"
  end

  create_table "historical_logs", charset: "utf8", force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "team_id"
    t.bigint "company_id"
    t.string "uuid", limit: 36, null: false
    t.integer "hms", default: 0
    t.integer "involvement", default: 0
    t.integer "points", default: 0
    t.string "level_name"
    t.integer "high5_total", default: 0
    t.integer "high5_received", default: 0
    t.integer "high5_given", default: 0
    t.integer "feedback_given", default: 0
    t.integer "company_ranking", default: 0
    t.integer "team_ranking", default: 0
    t.integer "results_good", default: 0
    t.integer "results_bad", default: 0
    t.integer "results_fine", default: 0
    t.integer "total_votes", default: 0
    t.integer "total_count", default: 0
    t.integer "total_pending", default: 0
    t.integer "active_employees", default: 0
    t.integer "comments", default: 0
    t.date "generated_on"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_historical_logs_on_company_id"
    t.index ["employee_id"], name: "index_historical_logs_on_employee_id"
    t.index ["generated_on"], name: "index_historical_logs_on_generated_on"
    t.index ["team_id"], name: "index_historical_logs_on_team_id"
    t.index ["uuid"], name: "index_historical_logs_on_uuid"
  end

  create_table "languages", charset: "utf8", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.string "name", limit: 50
    t.string "code", limit: 8
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uuid"], name: "index_languages_on_uuid"
  end

  create_table "notes", charset: "utf8", force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "receiver_id"
    t.string "uuid", limit: 36, null: false
    t.text "description"
    t.boolean "done", default: false
    t.boolean "shared", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_notes_on_employee_id"
    t.index ["receiver_id"], name: "index_notes_on_receiver_id"
    t.index ["shared"], name: "index_notes_on_shared"
    t.index ["uuid"], name: "index_notes_on_uuid"
  end

  create_table "poll_options", charset: "utf8", force: :cascade do |t|
    t.bigint "poll_id"
    t.string "uuid", limit: 36, null: false
    t.string "title"
    t.integer "category", default: 0
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["poll_id"], name: "index_poll_options_on_poll_id"
    t.index ["uuid"], name: "index_poll_options_on_uuid"
  end

  create_table "poll_votes", charset: "utf8", force: :cascade do |t|
    t.bigint "poll_id"
    t.string "uuid", limit: 36, null: false
    t.string "result"
    t.string "option_title"
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["poll_id"], name: "index_poll_votes_on_poll_id"
    t.index ["uuid"], name: "index_poll_votes_on_uuid"
  end

  create_table "polls", charset: "utf8", force: :cascade do |t|
    t.bigint "company_id"
    t.string "uuid", limit: 36, null: false
    t.boolean "active", default: false
    t.string "name"
    t.string "title"
    t.text "description"
    t.integer "poll_votes_count", default: 0
    t.string "slug"
    t.boolean "show_options", default: true
    t.boolean "show_comments", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_polls_on_company_id"
    t.index ["slug"], name: "index_polls_on_slug"
    t.index ["uuid"], name: "index_polls_on_uuid"
  end

  create_table "replies", charset: "utf8", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.bigint "vote_id"
    t.bigint "employee_id"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_replies_on_employee_id"
    t.index ["uuid"], name: "index_replies_on_uuid"
    t.index ["vote_id"], name: "index_replies_on_vote_id"
  end

  create_table "rewards", charset: "utf8", force: :cascade do |t|
    t.bigint "company_id"
    t.integer "category"
    t.string "uuid", limit: 36, null: false
    t.string "name", limit: 50, null: false
    t.text "description"
    t.boolean "active", default: true
    t.string "image_path"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["active"], name: "index_rewards_on_active"
    t.index ["category"], name: "index_rewards_on_category"
    t.index ["company_id"], name: "index_rewards_on_company_id"
    t.index ["uuid"], name: "index_rewards_on_uuid"
  end

  create_table "rules", charset: "utf8", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.string "name", limit: 50, null: false
    t.bigint "reward_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reward_id"], name: "index_rules_on_reward_id"
    t.index ["uuid"], name: "index_rules_on_uuid"
  end

  create_table "teams", charset: "utf8", force: :cascade do |t|
    t.bigint "company_id"
    t.string "uuid", limit: 36, null: false
    t.string "name"
    t.integer "employees_count", default: 0
    t.integer "hms", default: 0
    t.integer "involvement", default: 0
    t.integer "results_good", default: 0
    t.integer "results_bad", default: 0
    t.integer "results_fine", default: 0
    t.integer "high5_received", default: 0
    t.integer "high5_given", default: 0
    t.integer "feedback_given", default: 0
    t.integer "comments", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_teams_on_company_id"
    t.index ["uuid"], name: "index_teams_on_uuid"
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "activation_state"
    t.string "activation_token"
    t.datetime "activation_token_expires_at"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.integer "failed_logins_count", default: 0
    t.datetime "lock_expires_at"
    t.string "unlock_token"
    t.index ["activation_token"], name: "index_users_on_activation_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
    t.index ["unlock_token"], name: "index_users_on_unlock_token"
    t.index ["uuid"], name: "index_users_on_uuid"
  end

  create_table "votes", charset: "utf8", force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "team_id"
    t.bigint "employee_id"
    t.string "uuid", limit: 36, null: false
    t.string "token", limit: 60
    t.integer "result"
    t.text "description"
    t.boolean "recent", default: true
    t.datetime "generated_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_votes_on_company_id"
    t.index ["employee_id"], name: "index_votes_on_employee_id"
    t.index ["recent"], name: "index_votes_on_recent"
    t.index ["result"], name: "index_votes_on_result"
    t.index ["team_id"], name: "index_votes_on_team_id"
    t.index ["token"], name: "index_votes_on_token"
    t.index ["uuid"], name: "index_votes_on_uuid"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
