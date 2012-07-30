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

ActiveRecord::Schema.define(:version => 20120730170205) do

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

  create_table "events", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.text     "description"
    t.decimal  "scale",       :precision => 8, :scale => 6
    t.boolean  "in_model"
    t.integer  "location_id"
    t.integer  "pro_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.decimal  "value",       :precision => 8, :scale => 6
    t.text     "description"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
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
    t.decimal  "value",       :precision => 4, :scale => 1
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "processes", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "value"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "species", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.decimal  "constant",   :precision => 8, :scale => 6
    t.decimal  "slope",      :precision => 8, :scale => 6
    t.boolean  "in_model"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
