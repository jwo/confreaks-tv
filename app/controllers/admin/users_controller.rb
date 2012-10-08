class Admin::UsersController < Admin::Controller
  def index
    @users = User.order("last_name, first_name")
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    @user.update_attributes(params[:user])

    if @user.save
      flash[:success] = "Your changes have been successfully saved."
      redirect_to admin_users_path
    else
      flash[:error] = "Your changes were not saved. #{@user.errors.full_messages}"
      redirect_to edit_admin_user_path(@user)
    end
  end
end
