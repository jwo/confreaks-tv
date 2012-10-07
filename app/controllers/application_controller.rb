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

  def login_required
    if !current_user
      respond_to do |format|
        format.html {
          redirect_to '/auth/confreaks_sso'
        }
        format.json {
          render :json => { 'error' => 'Access Denied' }.to_json
        }
      end
    end
  end

  def current_user
    puts "IN CURRENT_USER in APPLICATION_CONTROLLER"
    return nil unless session[:user_id]
    @current_user ||= User.find_by_uid(session[:user_id]['uid'])
  end
end
