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

ActiveRecord::Schema.define(version: 2018_07_05_223517) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "image"
    t.string "url"
  end

  create_table "shows", force: :cascade do |t|
    t.bigint "theater_id"
    t.bigint "movie_id"
    t.date "date"
    t.datetime "start"
    t.datetime "end"
    t.string "version"
    t.string "url"
    t.index ["movie_id"], name: "index_shows_on_movie_id"
    t.index ["theater_id"], name: "index_shows_on_theater_id"
  end

  create_table "theaters", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "image"
    t.string "path"
  end

end
