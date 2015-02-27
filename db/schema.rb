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

ActiveRecord::Schema.define(version: 20150227023554) do

  create_table "chinese_horoscopes", force: true do |t|
    t.string   "animal"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chinese_horoscopes", ["animal"], name: "index_chinese_horoscopes_on_animal"

  create_table "movies", force: true do |t|
    t.string   "year"
    t.string   "bestMovie"
    t.text     "producers"
    t.text     "nominees"
    t.string   "bestActor"
    t.string   "bestActorMovie"
    t.string   "bestActress"
    t.string   "bestActressMovie"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movies", ["year"], name: "index_movies_on_year"

  create_table "random_facts", force: true do |t|
    t.date     "date"
    t.string   "gold"
    t.string   "dowjones"
    t.string   "homeprice"
    t.string   "newcar"
    t.string   "bread"
    t.string   "gas"
    t.string   "population"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "random_facts", ["date"], name: "index_random_facts_on_date"

  create_table "songlists", force: true do |t|
    t.string   "year"
    t.text     "songs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "songlists", ["year"], name: "index_songlists_on_year"

  create_table "zodiacs", force: true do |t|
    t.string   "sign"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zodiacs", ["sign"], name: "index_zodiacs_on_sign"

end
