class PresentersController < ApplicationController
  def index
    @presenters = Presenter.where('id in (select distinct(presenter_id) from presentations p inner join videos v on p.video_id = v.id where v.available = true)').order(:last_name, :first_name)
    if params[:view] == "pictures"
      render :template => 'presenters/index-pictures'
    else
      render :template => 'presenters/index'
    end
  end
  
  def show
    @presenter = Presenter.find(params[:id])
  end
end
