class Admin::Controller < ApplicationController

  before_filter :require_user
  before_filter :require_admin_user

  def require_admin_user
    if current_user.is_admin?
      true
    else
      redirect_to root_path()
    end
  end
end

