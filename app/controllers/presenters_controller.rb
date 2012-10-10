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

  def edit
    @presenter = Presenter.find(params[:id])

    unless current_user && current_user.is_admin?
      @presenter = current_user.presenter
    end
  end

  def update
    @presenter = Presenter.find(params[:id])

    @presenter.update_attributes(params[:presenter])

    if @presenter.save
      flash[:success] = "Your changes have been successfully saved."
      redirect_to my_account_path
    else
      flash[:error] = "You need to address the following items:"
      redirect_to my_account_path
    end
  end
end
