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

ActiveRecord::Schema.define(:version => 20130114213415) do

  create_table "athletes", :force => true do |t|
    t.integer  "user_id"
    t.date     "dateOfBirth"
    t.integer  "phoneNumber"
    t.string   "nationality"
    t.integer  "contact_id"
    t.string   "type"
    t.integer  "previousTime"
    t.string   "organisationTag"
    t.integer  "team_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "athletes", ["contact_id"], :name => "index_athletes_on_contact_id"
  add_index "athletes", ["team_id"], :name => "index_athletes_on_team_id"
  add_index "athletes", ["user_id"], :name => "index_athletes_on_user_id"

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "line1"
    t.string   "line2"
    t.string   "city"
    t.string   "country"
    t.string   "postcode"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.time     "start"
    t.time     "end"
    t.date     "date"
    t.string   "status"
    t.integer  "official_id"
    t.integer  "tournament_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "events", ["official_id"], :name => "index_events_on_official_id"
  add_index "events", ["tournament_id"], :name => "index_events_on_tournament_id"

  create_table "hurdle_matches", :force => true do |t|
    t.integer  "event_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "hurdle_matches", ["event_id"], :name => "index_hurdle_matches_on_event_id"

  create_table "hurdle_times", :force => true do |t|
    t.integer  "athlete_id"
    t.integer  "hurdle_match_id"
    t.time     "time"
    t.integer  "lane"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "hurdle_times", ["athlete_id"], :name => "index_hurdle_times_on_athlete_id"
  add_index "hurdle_times", ["hurdle_match_id"], :name => "index_hurdle_times_on_hurdle_match_id"

  create_table "officials", :force => true do |t|
    t.integer  "user_id"
    t.integer  "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "officials", ["user_id"], :name => "index_officials_on_user_id"

  create_table "sport_centers", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_town"
    t.string   "address_city"
    t.string   "address_postcode"
    t.integer  "contact_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "sport_centers", ["contact_id"], :name => "index_sport_centers_on_contact_id"

  create_table "sports", :force => true do |t|
    t.string   "name"
    t.integer  "length"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teams", :force => true do |t|
    t.integer  "User_id"
    t.string   "teamName"
    t.string   "badge_file_name"
    t.string   "badge_content_type"
    t.integer  "badge_file_size"
    t.datetime "badge_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "teams", ["User_id"], :name => "index_teams_on_User_id"

  create_table "tournaments", :force => true do |t|
    t.string   "name"
    t.date     "startDate"
    t.date     "endDate"
    t.integer  "sport_id"
    t.integer  "max_competitors"
    t.decimal  "adult_ticket_price",      :precision => 2, :scale => 0
    t.decimal  "concession_ticket_price", :precision => 2, :scale => 0
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
  end

  add_index "tournaments", ["sport_id"], :name => "index_tournaments_on_sport_id"

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

  create_table "wattball_matches", :force => true do |t|
    t.integer  "event_id"
    t.integer  "team1_id"
    t.integer  "team2_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "wattball_matches", ["event_id"], :name => "index_wattball_matches_on_event_id"
  add_index "wattball_matches", ["team1_id"], :name => "index_wattball_matches_on_team1_id"
  add_index "wattball_matches", ["team2_id"], :name => "index_wattball_matches_on_team2_id"

end
