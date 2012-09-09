class CreateConferences < ActiveRecord::Migration
  def change
    create_table :conferences do |t|
      t.string    :name
      t.integer   :organization_id
      
      t.timestamps
    end
  end
end
