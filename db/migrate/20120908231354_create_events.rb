class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string   :short_code
      t.datetime :start_at
      t.datetime :end_at
      t.string   :url
      t.integer  :conference_id
      t.string   :name_suffix
      t.string   :name_prefix
      t.string   :logo_file_name
      t.string   :logo_content_type
      t.integer  :logo_file_size
      t.datetime :logo_updated_at
      t.text     :notes               
      t.boolean  :ready               , :default => true
      t.boolean  :display             , :default => true
      t.integer  :rooms               , :default => 1
      t.boolean  :private             , :default => false
      t.timestamps
    end
    add_index :events, :short_code
  end
end
