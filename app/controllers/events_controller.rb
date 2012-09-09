class EventsController < ApplicationController
  def show
    @event = Event.find_by_identifier(params[:id])
  end

  def index
    @events = Event.active.order("start_at desc")
  end
end
