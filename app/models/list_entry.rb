class ListEntry < ActiveRecord::Base
  attr_accessible :list_id, :video_id

  belongs_to :list
  belongs_to :video
end
