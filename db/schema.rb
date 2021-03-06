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

ActiveRecord::Schema.define(version: 20131008044558) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "follows", force: true do |t|
    t.integer  "user_id",                  null: false
    t.integer  "follower_id",              null: false
    t.integer  "lock_version", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", force: true do |t|
    t.string   "name",                     null: false
    t.string   "location"
    t.string   "website"
    t.string   "bio"
    t.string   "photo"
    t.integer  "lock_version", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "tweet_targets", force: true do |t|
    t.integer  "lock_version", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "tweet_id"
  end

  create_table "tweets", force: true do |t|
    t.string   "msg",          limit: 140
    t.integer  "lock_version",             default: 0,     null: false
    t.string   "converse"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "targeted",                 default: false, null: false
  end

  create_table "users", force: true do |t|
    t.string   "handle",                      null: false
    t.integer  "lock_version",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest",             null: false
  end

  add_index "users", ["handle"], name: "index_users_on_handle", unique: true, using: :btree

end
