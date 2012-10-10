class Admin::ConferencesController < Admin::Controller
  def index
    @conferences = Conference.order("name")
  end
end
