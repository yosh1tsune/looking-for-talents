# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_17_231800) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "city"
    t.string "country"
    t.string "zipcode"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_candidates_on_email", unique: true
    t.index ["reset_password_token"], name: "index_candidates_on_reset_password_token", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.string "comment"
    t.bigint "profile_id", null: false
    t.bigint "headhunter_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["headhunter_id"], name: "index_comments_on_headhunter_id"
    t.index ["profile_id"], name: "index_comments_on_profile_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "document"
    t.string "description"
    t.bigint "headhunter_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.string "phone"
    t.index ["headhunter_id"], name: "index_companies_on_headhunter_id"
  end

  create_table "headhunters", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "surname"
    t.index ["email"], name: "index_headhunters_on_email", unique: true
    t.index ["reset_password_token"], name: "index_headhunters_on_reset_password_token", unique: true
  end

  create_table "opportunities", force: :cascade do |t|
    t.string "title"
    t.text "work_description"
    t.text "required_abilities"
    t.string "salary"
    t.string "grade"
    t.date "submit_end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.index ["opportunity_id"], name: "index_proposals_on_opportunity_id"
    t.index ["subscription_id"], name: "index_proposals_on_subscription_id"
  end

  create_table "servicing_headhunters", force: :cascade do |t|
    t.bigint "headhunter_id", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["candidate_id"], name: "index_subscriptions_on_candidate_id"
    t.index ["opportunity_id"], name: "index_subscriptions_on_opportunity_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "headhunters"
  add_foreign_key "comments", "profiles"
  add_foreign_key "companies", "headhunters"
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
