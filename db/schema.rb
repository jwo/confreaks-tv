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

ActiveRecord::Schema.define(:version => 20120908171138) do

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
