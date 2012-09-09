##
# the standard rails application_controller
class ApplicationController < ActionController::Base
  protect_from_forgery

  def recents
    @recent_events = Event.active.find(:all,
                                       :order => 'start_at desc',
                                       :limit =>5)

    @recent_videos = @recent_events.map {|event| event.videos.first}
  end
end
