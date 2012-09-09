class PresentersController < ApplicationController
  def show
    @presenter = Presenter.find(params[:id])
  end
end
