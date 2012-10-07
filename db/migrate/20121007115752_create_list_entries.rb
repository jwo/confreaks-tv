class CreateListEntries < ActiveRecord::Migration
  def change
    create_table :list_entries do |t|
      t.integer :list_id
      t.integer :video_id

      t.timestamps
    end
  end
end
