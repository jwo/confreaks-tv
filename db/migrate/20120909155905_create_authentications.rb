class CreateAuthentications < ActiveRecord::Migration
  def change
    if ActiveRecord::Base.connection.table_exists? :authentications
      puts "An authentications table already exists, skipping creation, if you're doing a rollback.  You have to decide if you want to manually drop authentications or leave it alone."
    else
      create_table :authentications do |t|
        t.integer :user_id
        t.string :provider
        t.string :uid
        
        t.timestamps
      end
    end
  end
end
