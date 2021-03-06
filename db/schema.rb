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

ActiveRecord::Schema.define(version: 20181207032812) do

  create_table "searches", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "search_term"
    t.string   "from_date"
    t.string   "to_date"
    t.string   "graph_data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "saved"
    t.string   "country"
    t.integer  "view_count",  default: 0
    t.string   "viewed_by",   default: "--- []\n"
  end

  create_table "searches_twitterhandles", force: :cascade do |t|
    t.integer  "search_id"
    t.integer  "twitterhandle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "graph_data"
    t.string   "number_of_tweets"
  end

  create_table "searches_users", force: :cascade do |t|
    t.integer "search_id"
    t.integer "user_id"
  end

  create_table "twitterhandles", force: :cascade do |t|
    t.string   "handle"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "user_name"
    t.string   "email"
    t.string   "password"
    t.string   "country"
    t.string   "session_token"
    t.string   "current_search"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "friends_list",   default: "--- []\n"
  end

end
