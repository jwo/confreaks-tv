class ConferencesController < ApplicationController
  def index
    @conferences = Conference.find_by_sql("select c.id, c.name, c.created_at, c.updated_at, c.organization_id, max(e.start_at) from conferences c inner join events e on e.conference_id = c.id where e.display = 1 and e.private = 0 group by c.id, c.name, c.created_at, c.updated_at, c.organization_id order by max(e.start_at)  desc;")

      #includes(:events).where("events.display = ? and events.private = ?", true, false).order("max(events.start_at) desc").group(c.name)uniq
  end

  def show
    @conference = Conference.find(params[:id])
  end
end
