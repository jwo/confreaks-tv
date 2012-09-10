class CreatePresentations < ActiveRecord::Migration
  def change
    unless ActiveRecord::Base.connection.table_exists? 'presentations'
      create_table :presentations do |t|
        t.integer :video_id
        t.integer :presenter_id
        
        t.timestamps
      end
    else
      puts "Not creating presentaitions, you already have one, I assume it's there because of restoring a production database."
    end
  end
end
