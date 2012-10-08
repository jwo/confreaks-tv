class Admin::PresentersController < ApplicationController
  def index
    @presenters = Presenter.order("last_name, first_name")
  end

  def edit
    @presenter = Presenter.find(params[:id])
  end

  def show
    @presenter = Presenter.find(params[:id])
  end

  def new
    @presenter = Presenter.new
  end

  def update
    @presenter = Presenter.find(params[:id])

    @presenter.update_attributes(params[:presenter])

    if @presenter.save
      flash[:success] = "Your changes have been successfully saved."
      if params[:commit]=="Save"
        redirect_to admin_presenters_path
      else
        redirect_to presenter_path(@presenter)
      end
    else
      flash[:error] = "You need to address the following items:"
      redirect_to edit_admin_presenter_path(@presenter)
    end
  end
end
