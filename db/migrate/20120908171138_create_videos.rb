class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string   :title,           :null => false
      t.datetime :recorded_at
      t.integer  :event_id
      t.boolean  :available,           :default => false
      t.boolean  :include_random,      :default => true
      t.string   :image_file_name
      t.string   :image_content_type
      t.integer  :image_file_size
      t.datetime :image_updated_at
      t.integer  :streaming_asset_id
      t.string   :rating,              :default => "Not Rated"
      t.text     :abstract
      t.datetime :post_date
      t.boolean  :announce,            :default => false
      t.datetime :announce_date
      t.text     :note
      t.integer  :room_id
      t.string   :youtube_code
      t.integer  :views,               :default => 0
      t.integer  :views_last_7,        :default => 0
      t.integer  :views_last_30,       :default => 0
      t.datetime :views_updated_at
      t.string   :license,             :default => "cc-by-sa-3.0"

      t.timestamps
    end
    
    add_index :videos, :event_id
    add_index :videos, :recorded_at
    add_index :videos, :title
  end
end
