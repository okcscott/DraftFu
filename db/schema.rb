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

ActiveRecord::Schema.define(:version => 20120816033314) do

  create_table "draft_picks", :force => true do |t|
    t.integer  "round"
    t.integer  "pick"
    t.integer  "player_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "timestamp"
    t.boolean  "missed",     :default => false
    t.integer  "league_id"
  end

  add_index "draft_picks", ["player_id"], :name => "index_draft_picks_on_player_id"
  add_index "draft_picks", ["team_id"], :name => "index_draft_picks_on_team_id"

  create_table "leagues", :force => true do |t|
    t.string   "name"
    t.integer  "commissioner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roster_spots"
    t.integer  "starting_qb"
    t.integer  "starting_wr"
    t.integer  "starting_rb"
    t.integer  "starting_te"
    t.integer  "starting_k"
    t.integer  "starting_def"
    t.integer  "pick",            :default => 1
    t.integer  "round",           :default => 1
    t.string   "slug"
  end

  add_index "leagues", ["commissioner_id"], :name => "index_leagues_on_commissioner_id"

  create_table "players", :force => true do |t|
    t.string   "name"
    t.string   "position"
    t.string   "yahooid"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bye_week"
    t.string   "team"
    t.string   "image_url"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.integer  "league_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pick"
  end

  add_index "teams", ["league_id"], :name => "index_teams_on_league_id"

  create_table "users", :force => true do |t|
    t.string   "email",            :null => false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
