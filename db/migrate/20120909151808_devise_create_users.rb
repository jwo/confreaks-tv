class DeviseCreateUsers < ActiveRecord::Migration
  def change
    if ActiveRecord::Base.connection.table_exists? :users
      puts "You have a user table, I'm assuming it is from a production restoration of confreaks.com"

      puts "\tRemoving unused columns"

      remove_column :users, :location
      remove_column :users, :session_token
      remove_column :users, :gender
      remove_column :users, :twitter_name
      remove_column :users, :facebook_token
      
      puts "\tAdding new columns"

      ## Database authenticatable
      add_column :users, :encrypted_password, :string, :null => false, :default => ""

      ## Recoverable
      add_column :users, :reset_password_token,   :string
      add_column :users, :reset_password_sent_on, :datetime

      ## Rememberable
      add_column :users, :remember_created_at,    :datetime

      ## Trackable
      add_column :users, :sign_in_count,          :integer, :default => 0
      add_column :users, :current_sign_in_at,     :datetime
      add_column :users, :last_sign_in_at,        :datetime
      add_column :users, :current_sign_in_ip,     :string
      add_column :users, :last_sign_in_ip,        :string

      ## Confirmable
      add_column :users, :confirmation_token,     :string
      add_column :users, :confirmed_at,           :datetime
      add_column :users, :confirmation_sent_at,   :datetime
      add_column :users, :unconfirmed_email,      :string

      ## Token authenticatable
      add_column :users, :authentication_token,   :string
    end

    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token,   :unique => true
    add_index :users, :authentication_token, :unique => true
  end
end
