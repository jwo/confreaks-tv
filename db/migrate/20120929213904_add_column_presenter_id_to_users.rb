class AddColumnPresenterIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :presenter_id, :integer
  end
end
