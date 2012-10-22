##
# the standard rails application_controller
class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  def recents
    @recent_events = Event.active.find(:all,
                                       :order => 'start_at desc',
                                       :limit =>5)

    @recent_videos = @recent_events.map {|event| event.videos.first}
  end

  # Customize the Devise after_sign_in_path_for() for redirecct to previous page after login
  def after_sign_in_path_for(resource_or_scope)
    case resource_or_scope
    when :user, User
      store_location = session[:return_to]
      clear_stored_location
      (store_location.nil?) ? (request.env['omniauth.origin'] || root_path) : store_location.to_s
    else
      super
    end
  end
  
  def set_time_zone
    if current_user && !current_user.time_zone.blank?
      Time.zone = current_user.time_zone
    end
  end
end
