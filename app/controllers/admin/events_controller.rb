class Admin::EventsController < Admin::Controller
  def index
    @events = Event.order("short_code")
  end
end
