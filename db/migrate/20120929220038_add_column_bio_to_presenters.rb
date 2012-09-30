class AddColumnBioToPresenters < ActiveRecord::Migration
  def change
    add_column :presenters, :bio, :text
  end
end
