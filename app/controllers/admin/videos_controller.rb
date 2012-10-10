class Admin::VideosController < Admin::Controller
  before_filter :require_user, :except => :callback
  before_filter :require_admin_user, :except => :callback

  protect_from_forgery :except => :callback

  def index
    @videos = Video.order("recorded_at desc")
  end
end
