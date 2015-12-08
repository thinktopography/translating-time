# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151208155401) do

  create_table "abbreviations", force: :cascade do |t|
    t.string "text",        limit: 255
    t.string "description", limit: 255
  end

  create_table "citations", force: :cascade do |t|
    t.text     "body",       limit: 65535
    t.integer  "pubmed_id",  limit: 4
    t.string   "authors",    limit: 255
    t.string   "title",      limit: 255
    t.string   "journal",    limit: 255
    t.string   "pagination", limit: 255
    t.string   "volume",     limit: 255
    t.date     "date"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "classifications", id: false, force: :cascade do |t|
    t.integer "taxonomy_id", limit: 4
    t.integer "species_id",  limit: 4
  end

  create_table "datasets", force: :cascade do |t|
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "model_id",   limit: 4
    t.string   "status",     limit: 255
    t.integer  "user_id",    limit: 4
    t.boolean  "is_active",              default: false, null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "errors", force: :cascade do |t|
    t.integer  "event_id",   limit: 4
    t.integer  "species_id", limit: 4
    t.decimal  "value",                precision: 7, scale: 5
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "estimates", force: :cascade do |t|
    t.integer  "event_id",   limit: 4
    t.integer  "species_id", limit: 4
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.decimal  "low",                  precision: 6, scale: 1
    t.decimal  "value",                precision: 6, scale: 1
    t.decimal  "high",                 precision: 6, scale: 1
    t.integer  "warning",    limit: 4,                         default: 0
    t.integer  "dataset_id", limit: 4
  end

  create_table "events", force: :cascade do |t|
    t.integer  "location_id", limit: 4
    t.integer  "process_id",  limit: 4
    t.string   "name",        limit: 255
    t.string   "code",        limit: 255
    t.text     "description", limit: 65535
    t.decimal  "scale",                     precision: 8, scale: 6
    t.boolean  "in_model",                                          default: false, null: false
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.text     "comment",     limit: 65535
  end

  create_table "inquiries", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "affiliation", limit: 255
    t.string   "email",       limit: 255
    t.text     "comments",    limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "code",        limit: 255
    t.decimal  "value",                     precision: 8, scale: 6
    t.text     "description", limit: 65535
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  create_table "menu_items", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "url",        limit: 255
    t.string   "target",     limit: 255
    t.integer  "delta",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "methods", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "models", force: :cascade do |t|
    t.text     "source",     limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "observations", force: :cascade do |t|
    t.integer  "citation_id", limit: 4
    t.integer  "event_id",    limit: 4
    t.integer  "species_id",  limit: 4
    t.integer  "method_id",   limit: 4
    t.integer  "user_id",     limit: 4
    t.decimal  "value",                 precision: 6, scale: 1
    t.boolean  "is_active",                                     default: false, null: false
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.string   "permalink",        limit: 255
    t.boolean  "is_published"
    t.text     "body",             limit: 65535
    t.string   "meta_keywords",    limit: 255
    t.string   "meta_description", limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "pages", ["permalink"], name: "index_pages_on_permalink", unique: true, using: :btree

  create_table "processes", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "code",        limit: 255
    t.string   "value",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "species", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "code",            limit: 255
    t.decimal  "constant",                    precision: 8, scale: 6
    t.decimal  "slope",                       precision: 8, scale: 6
    t.boolean  "in_model",                                            default: false, null: false
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
    t.string   "scientific_name", limit: 255
    t.string   "precocial_score", limit: 255
    t.string   "brain",           limit: 255
    t.string   "weight",          limit: 255
    t.string   "gestation",       limit: 255
  end

  create_table "taxonomies", force: :cascade do |t|
    t.integer  "parent_id",  limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "code",       limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "email",                  limit: 255, default: "",    null: false
    t.integer  "role_id",                limit: 4
    t.boolean  "change_password",                    default: false, null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
