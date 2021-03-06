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

ActiveRecord::Schema.define(version: 2018_07_10_181950) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "image"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "external_id"
    t.string "chain"
  end

  create_table "shows", force: :cascade do |t|
    t.bigint "theater_id"
    t.bigint "movie_id"
    t.date "date"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string "version"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_shows_on_movie_id"
    t.index ["theater_id"], name: "index_shows_on_theater_id"
  end

  create_table "suggestions", force: :cascade do |t|
    t.string "key"
    t.string "show_key"
    t.string "movie_key"
    t.string "theater_key"
    t.date "date"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer "wait_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shows_amount"
    t.integer "theaters_amount"
  end

  create_table "theaters", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "image"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "chain"
    t.integer "external_id"
  end

end
