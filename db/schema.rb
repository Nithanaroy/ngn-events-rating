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

ActiveRecord::Schema.define(version: 20140225140223) do

  create_table "authorizations", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "name",                      null: false
    t.text     "details"
    t.string   "place",                     null: false
    t.datetime "from",                      null: false
    t.datetime "to",                        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",                   null: false
    t.boolean  "show",       default: true, null: false
  end

  create_table "events_ratings", id: false, force: true do |t|
    t.integer  "event_id",   null: false
    t.string   "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "going"
    t.integer  "user_id",    null: false
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "image_url"
    t.string   "gender",     limit: 10
  end

end
