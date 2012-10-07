class MyAccountController < ApplicationController
  before_filter :authenticate_user!

  def show
    # operates on current_user only
  end

  def edit
    # operates on current_user only
  end

  def update
    current_user.update_attributes(params[:user])
    if current_user.save!
      flash[:success] = "Your changes were saved successfully!"
    else
      flash[:error] = "We were unable to save your changes."
      # TODO add display of user.errors.full_messages here
    end

    redirect_to my_account_path
  end

  def claim_presenter
    @presenter = Presenter.find(params[:id])
    if current_user.presenter
      flash[:error] = "You already have a presenter profile '#{current_user.presenter.display_name}' associated with this account."
    else
      current_user.presenter = @presenter
      if current_user.save
        flash[:success] = "This presenter profile is now associated with you."
      else
        flash[:error] = "We were unable to associate this presenter with your account."
      end
    end
    redirect_to presenter_path(@presenter)
  end
end
