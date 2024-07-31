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

ActiveRecord::Schema[7.1].define(version: 2024_07_31_033644) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "city"
    t.string "country"
    t.string "zipcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "neighborhood"
    t.string "state"
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "candidates", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["email"], name: "index_candidates_on_email", unique: true
    t.index ["reset_password_token"], name: "index_candidates_on_reset_password_token", unique: true
  end

  create_table "chats", force: :cascade do |t|
    t.bigint "headhunter_id", null: false
    t.bigint "candidate_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "websocket_uuid", null: false
    t.index ["candidate_id"], name: "index_chats_on_candidate_id"
    t.index ["headhunter_id"], name: "index_chats_on_headhunter_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "comment"
    t.bigint "profile_id", null: false
    t.bigint "headhunter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["headhunter_id"], name: "index_comments_on_headhunter_id"
    t.index ["profile_id"], name: "index_comments_on_profile_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "document"
    t.string "description"
    t.bigint "headhunter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "phone"
    t.index ["headhunter_id"], name: "index_companies_on_headhunter_id"
  end

  create_table "experiences", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.string "resume"
    t.date "start_date"
    t.date "end_date"
    t.boolean "currently_working", default: false
    t.string "company"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_experiences_on_profile_id"
  end

  create_table "headhunters", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "surname"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["email"], name: "index_headhunters_on_email", unique: true
    t.index ["reset_password_token"], name: "index_headhunters_on_reset_password_token", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "chat_id", null: false
    t.string "from_type", null: false
    t.bigint "from_id", null: false
    t.string "to_type", null: false
    t.bigint "to_id", null: false
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["from_type", "from_id"], name: "index_messages_on_from"
    t.index ["to_type", "to_id"], name: "index_messages_on_to"
  end

  create_table "opportunities", force: :cascade do |t|
    t.string "title"
    t.text "work_description"
    t.text "required_abilities"
    t.string "salary"
    t.string "grade"
    t.date "submit_end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.bigint "headhunter_id"
    t.bigint "company_id", default: 0, null: false
    t.index ["company_id"], name: "index_opportunities_on_company_id"
    t.index ["headhunter_id"], name: "index_opportunities_on_headhunter_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.date "birth_date"
    t.string "document"
    t.string "scholarity"
    t.text "professional_resume"
    t.boolean "highlighted", default: false
    t.bigint "candidate_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_profiles_on_candidate_id"
  end

  create_table "proposals", force: :cascade do |t|
    t.date "start_date"
    t.decimal "salary"
    t.text "benefits"
    t.text "role"
    t.text "expectations"
    t.text "bonuses"
    t.bigint "subscription_id", null: false
    t.bigint "opportunity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["opportunity_id"], name: "index_proposals_on_opportunity_id"
    t.index ["subscription_id"], name: "index_proposals_on_subscription_id"
  end

  create_table "servicing_headhunters", force: :cascade do |t|
    t.bigint "headhunter_id", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_servicing_headhunters_on_company_id"
    t.index ["headhunter_id"], name: "index_servicing_headhunters_on_headhunter_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "candidate_id", null: false
    t.bigint "opportunity_id", null: false
    t.text "registration_resume"
    t.boolean "highlighted"
    t.integer "status", default: 0
    t.text "feedback"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_subscriptions_on_candidate_id"
    t.index ["opportunity_id"], name: "index_subscriptions_on_opportunity_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "chats", "candidates"
  add_foreign_key "chats", "headhunters"
  add_foreign_key "comments", "headhunters"
  add_foreign_key "comments", "profiles"
  add_foreign_key "companies", "headhunters"
  add_foreign_key "experiences", "profiles"
  add_foreign_key "messages", "chats"
  add_foreign_key "opportunities", "companies"
  add_foreign_key "opportunities", "headhunters"
  add_foreign_key "profiles", "candidates"
  add_foreign_key "proposals", "opportunities"
  add_foreign_key "proposals", "subscriptions"
  add_foreign_key "servicing_headhunters", "companies"
  add_foreign_key "servicing_headhunters", "headhunters"
  add_foreign_key "subscriptions", "candidates"
  add_foreign_key "subscriptions", "opportunities"
end
