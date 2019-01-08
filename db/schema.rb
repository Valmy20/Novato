# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_01_08_113208) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "token_reset"
    t.boolean "status"
    t.boolean "deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.boolean "status"
    t.boolean "deleted"
    t.bigint "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_categories_on_admin_id"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "employer_extras", force: :cascade do |t|
    t.text "about"
    t.string "phone"
    t.bigint "employer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
    t.index ["employer_id"], name: "index_employer_extras_on_employer_id"
  end

  create_table "employers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "logo"
    t.string "token_reset"
    t.string "slug"
    t.integer "status"
    t.boolean "deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "institution_extras", force: :cascade do |t|
    t.text "about"
    t.string "phone"
    t.string "location"
    t.bigint "institution_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_institution_extras_on_institution_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "token_reset"
    t.string "logo"
    t.string "cover"
    t.string "slug"
    t.integer "status"
    t.boolean "deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "publications", force: :cascade do |t|
    t.string "title"
    t.integer "_type"
    t.text "information"
    t.integer "remunaration"
    t.integer "vacancies"
    t.string "location"
    t.string "slug"
    t.boolean "deleted", default: false
    t.string "publicationable_type"
    t.integer "publicationable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_skills_on_user_id"
  end

  create_table "user_extras", force: :cascade do |t|
    t.text "bio"
    t.string "phone"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_extras_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "avatar"
    t.string "cover"
    t.string "uid"
    t.integer "status", default: 0
    t.string "provider"
    t.string "token_reset"
    t.json "credentials"
    t.string "slug"
    t.boolean "deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "categories", "admins"
  add_foreign_key "employer_extras", "employers"
  add_foreign_key "institution_extras", "institutions"
  add_foreign_key "skills", "users"
  add_foreign_key "user_extras", "users"
end
