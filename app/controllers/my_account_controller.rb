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
end
