class CreatePresenters < ActiveRecord::Migration
  def change
    create_table :presenters do |t|

      t.timestamps
    end
  end
end
