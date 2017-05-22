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

ActiveRecord::Schema.define(version: 20170522143001) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "code"
  end

  create_table "locations_projects", id: false, force: :cascade do |t|
    t.integer "project_id",  null: false
    t.integer "location_id", null: false
    t.index ["project_id", "location_id"], name: "index_locations_projects_on_project_id_and_location_id", using: :btree
  end

  create_table "organizations", force: :cascade do |t|
    t.boolean  "legally_formed"
    t.string   "email"
    t.string   "telephone_number"
    t.string   "name"
    t.string   "twitter"
    t.string   "facebook"
    t.boolean  "accepted"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "logo"
    t.index ["user_id"], name: "index_organizations_on_user_id", using: :btree
  end

  create_table "populations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "populations_projects", id: false, force: :cascade do |t|
    t.integer "project_id",    null: false
    t.integer "population_id", null: false
    t.index ["project_id", "population_id"], name: "index_populations_projects_on_project_id_and_population_id", using: :btree
  end

  create_table "project_goals", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "goal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["goal"], name: "index_project_goals_on_goal", using: :btree
    t.index ["project_id"], name: "index_project_goals_on_project_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "organization_id"
    t.string   "location"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "published"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["organization_id"], name: "index_projects_on_organization_id", using: :btree
  end

  create_table "sustainable_development_goals", force: :cascade do |t|
    t.string   "name"
    t.integer  "number"
    t.string   "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.boolean  "admin"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "organizations", "users"
  add_foreign_key "project_goals", "projects"
  add_foreign_key "projects", "organizations"
end
