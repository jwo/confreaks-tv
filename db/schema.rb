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

ActiveRecord::Schema.define(:version => 20120909155905) do

  create_table "activities", :force => true do |t|
    t.string   "message"
    t.integer  "user_id"
    t.boolean  "suppressed", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asset_types", :force => true do |t|
    t.string   "description"
    t.boolean  "streaming"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "downloadable", :default => true
  end

  create_table "assets", :force => true do |t|
    t.integer  "video_id"
    t.integer  "asset_type_id"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.integer  "height",                :default => 0
    t.integer  "width",                 :default => 0
    t.string   "duration"
    t.integer  "zencoder_job_id"
    t.boolean  "zencoder_job_complete", :default => false
    t.text     "zencoder_response"
    t.integer  "zencoder_output_id"
    t.integer  "generated_by_asset_id", :default => 0
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uie"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "conferences", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  create_table "events", :force => true do |t|
    t.string   "short_code"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.integer  "conference_id"
    t.string   "name_suffix"
    t.string   "name_prefix"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.text     "notes"
    t.boolean  "ready",             :default => true
    t.boolean  "display",           :default => true
    t.integer  "rooms",             :default => 1
    t.boolean  "private",           :default => false
  end

  add_index "events", ["short_code"], :name => "by_short_code"

  create_table "histories", :force => true do |t|
    t.string   "controller"
    t.string   "action"
    t.integer  "user_id"
    t.integer  "param_id"
    t.string   "ip_address"
    t.string   "referrer"
    t.string   "url"
    t.string   "uri"
    t.string   "http_method"
    t.string   "query_string"
    t.string   "session_token"
    t.string   "user_agent"
    t.string   "protocol"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "histories", ["controller", "action", "param_id"], :name => "by_controller_action_param_id"

  create_table "organization_users", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "presentations", :force => true do |t|
    t.integer  "presenter_id"
    t.integer  "video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "presenters", :force => true do |t|
    t.string   "aka_name"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "twitter_handle"
  end

  create_table "rooms", :force => true do |t|
    t.integer  "event_id"
    t.integer  "number"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "t", :id => false, :force => true do |t|
    t.integer "i"
    t.text    "t"
  end

  create_table "users", :force => true do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "videos", :force => true do |t|
    t.string   "title",                                          :null => false
    t.datetime "recorded_at"
    t.integer  "event_id"
    t.boolean  "available",          :default => false
    t.boolean  "include_random",     :default => true
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "streaming_asset_id"
    t.string   "rating",             :default => "Not Rated"
    t.text     "abstract"
    t.datetime "post_date"
    t.boolean  "announce",           :default => false
    t.datetime "announce_date"
    t.text     "note"
    t.integer  "room_id"
    t.string   "youtube_code"
    t.integer  "views",              :default => 0
    t.integer  "views_last_7",       :default => 0
    t.integer  "views_last_30",      :default => 0
    t.datetime "views_updated_at"
    t.string   "license",            :default => "cc-by-sa-3.0"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "videos", ["event_id"], :name => "index_videos_on_event_id"
  add_index "videos", ["recorded_at"], :name => "index_videos_on_recorded_at"
  add_index "videos", ["title"], :name => "index_videos_on_title"

end
