class CreateConferences < ActiveRecord::Migration
  def change
    unless ActiveRecord::Base.connection.table_exists? 'conferences'
      create_table :conferences do |t|
        t.string    :name
        t.integer   :organization_id
        
        t.timestamps
      end
    else
      puts "Not creating conferences, you already have one, I assume it's there because of restoing a production database."
    end
  end
end
