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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140508144411) do

  create_table "abbreviations", :force => true do |t|
    t.string "text"
    t.string "description"
  end

  create_table "citations", :force => true do |t|
    t.text     "body"
    t.integer  "pubmed_id"
    t.string   "authors"
    t.string   "title"
    t.string   "journal"
    t.string   "pagination"
    t.string   "volume"
    t.date     "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "classifications", :id => false, :force => true do |t|
    t.integer "taxonomy_id"
    t.integer "species_id"
  end

  create_table "errors", :force => true do |t|
    t.integer  "event_id"
    t.integer  "species_id"
    t.decimal  "value",      :precision => 7, :scale => 5
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "estimates", :force => true do |t|
    t.integer  "event_id"
    t.integer  "species_id"
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
    t.decimal  "low",        :precision => 6, :scale => 1
    t.decimal  "value",      :precision => 6, :scale => 1
    t.decimal  "high",       :precision => 6, :scale => 1
    t.integer  "warning",                                  :default => 0
  end

  create_table "events", :force => true do |t|
    t.integer  "location_id"
    t.integer  "process_id"
    t.string   "name"
    t.string   "code"
    t.text     "description"
    t.decimal  "scale",       :precision => 8, :scale => 6
    t.boolean  "in_model",                                  :default => false, :null => false
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
    t.text     "comment"
  end

  create_table "inquiries", :force => true do |t|
    t.string   "name"
    t.string   "affiliation"
    t.string   "email"
    t.text     "comments"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.decimal  "value",       :precision => 8, :scale => 6
    t.text     "description"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "menu_items", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "target"
    t.integer  "delta"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "methods", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "observations", :force => true do |t|
    t.integer  "citation_id"
    t.integer  "event_id"
    t.integer  "species_id"
    t.integer  "method_id"
    t.integer  "user_id"
    t.decimal  "value",       :precision => 6, :scale => 1
    t.boolean  "is_active",                                 :default => false, :null => false
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "permalink"
    t.boolean  "is_published"
    t.text     "body"
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "pages", ["permalink"], :name => "index_pages_on_permalink", :unique => true

  create_table "processes", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "value"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "species", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.decimal  "constant",        :precision => 8, :scale => 6
    t.decimal  "slope",           :precision => 8, :scale => 6
    t.boolean  "in_model",                                      :default => false, :null => false
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
    t.string   "scientific_name"
    t.string   "precocial_score"
    t.string   "brain"
    t.string   "weight"
    t.string   "gestation"
  end

  create_table "taxonomies", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  :default => "",    :null => false
    t.integer  "role_id"
    t.boolean  "change_password",        :default => false, :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
