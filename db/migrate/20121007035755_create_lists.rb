class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string  :name
      t.string  :description
      t.boolean :public, :default => true
      t.integer :user_id
      
      t.timestamps
    end
  end
end
