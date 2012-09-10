class CreateAuthentications < ActiveRecord::Migration
  def change
    if ActiveRecord::Base.connection.table_exists? :authentications
      puts "You know the drill."
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
