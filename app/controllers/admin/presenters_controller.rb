class Admin::PresentersController < ApplicationController
  def index
    @presenters = Presenter.order("last_name, first_name")
  end
end
