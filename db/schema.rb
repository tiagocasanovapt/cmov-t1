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

ActiveRecord::Schema.define(:version => 20121111015345) do

  create_table "connections", :force => true do |t|
    t.integer "first_station_id"
    t.integer "last_station_id"
    t.integer "order_num"
    t.integer "distance"
    t.integer "line_id"
  end

  create_table "credits", :force => true do |t|
    t.integer "card_type",                :null => false
    t.string  "number",     :limit => 16, :null => false
    t.integer "ccv",                      :null => false
    t.date    "expiration",               :null => false
    t.integer "user_id"
  end

  create_table "lines", :force => true do |t|
    t.string  "name"
    t.integer "totalTime"
    t.integer "first_station_id"
    t.integer "last_station_id"
  end

  create_table "lines_stations", :id => false, :force => true do |t|
    t.integer "line_id"
    t.integer "station_id"
  end

  add_index "lines_stations", ["line_id", "station_id"], :name => "index_lines_stations_on_line_id_and_station_id"

  create_table "paths", :force => true do |t|
    t.integer "direction"
    t.time    "start_time"
    t.string  "train"
    t.integer "capacity"
    t.integer "line_id"
  end

  create_table "prices", :force => true do |t|
    t.decimal "price", :precision => 8, :scale => 4
  end

  create_table "reservations", :force => true do |t|
    t.integer "user_id"
    t.integer "path_id"
    t.integer "first_station_id"
    t.integer "last_station_id"
    t.date    "reserv_date"
    t.boolean "paid",             :default => false
    t.string  "ticket"
    t.boolean "verified",         :default => false
  end

  create_table "stations", :force => true do |t|
    t.string "name"
  end

  create_table "stops", :force => true do |t|
    t.time    "stop_time"
    t.integer "station_id"
    t.integer "path_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.boolean  "supervisor",             :default => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
