class AddColumnShowFeaturedVideoToPresenters < ActiveRecord::Migration
  def change
    add_column :presenters, :show_featured_video, :boolean, :default => true
  end
end
