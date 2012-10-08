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

  def require_user
    if !current_user
      flash[:error] = "You must be signed in for that!"
      session.bookmark = url_for params

      respond_to do |format|
        format.html {redirect_to root_path}
      end
    end
  end

  def set_time_zone
    unless session.anonymous? || session.user.time_zone.blank?
      Time.zone = current_user.time_zone
    end
  end
end
