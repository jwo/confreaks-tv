class AddColumnFavoriteVideoIdToPresenters < ActiveRecord::Migration
  def change
    add_column :presenters, :favorite_video_id, :integer
  end
end
