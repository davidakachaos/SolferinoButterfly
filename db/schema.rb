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

ActiveRecord::Schema.define(version: 20160418191731) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "episodes", force: :cascade do |t|
    t.string   "name"
    t.integer  "season_id"
    t.integer  "state"
    t.integer  "number"
    t.integer  "tvdb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "episodes", ["season_id"], name: "index_episodes_on_season_id", using: :btree

  create_table "seasons", force: :cascade do |t|
    t.integer  "serie_id"
    t.integer  "state"
    t.integer  "number"
    t.integer  "tvdb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "seasons", ["serie_id"], name: "index_seasons_on_serie_id", using: :btree

  create_table "series", force: :cascade do |t|
    t.text     "actors"
    t.string   "airs_dayofweek"
    t.string   "airs_time"
    t.string   "content_raiting"
    t.date     "first_aired"
    t.string   "genre"
    t.string   "imdb_id"
    t.string   "language"
    t.string   "network"
    t.integer  "network_id"
    t.text     "overview"
    t.string   "rating"
    t.integer  "raring_count"
    t.string   "runtime"
    t.integer  "series_id"
    t.string   "series_name"
    t.string   "status"
    t.date     "added"
    t.string   "added_by"
    t.string   "banner"
    t.string   "fanart"
    t.datetime "last_updated"
    t.string   "poster"
    t.string   "zap2it_id"
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "path"
  end

end
