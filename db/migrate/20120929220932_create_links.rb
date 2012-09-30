class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.string :description
      t.integer :linkable_id
      t.integer :linkable_type
      t.integer :added_by_user_id
      t.timestamps
    end
  end
end
