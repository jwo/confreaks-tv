class CreatePresenters < ActiveRecord::Migration
  def change
    unless ActiveRecord::Base.connection.table_exists? 'presenters'
      create_table :presenters do |t|
        t.string :first_name
        t.string :last_name
        t.string :aka_name
        t.integer :user_id
        t.string :twitter_handle
        
        t.timestamps
      end
    else
      puts "Not creating presenters table, you already have one, I assume that is because you restored a production backup."
    end
  end
end
