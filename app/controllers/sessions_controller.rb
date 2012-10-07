class SessionsController < Devise::SessionsController

  def create
    logger.info "Attempt to sign in by #{params[:user][:email] }"

    super

    if current_user
      #check_event_entry
    end

  end

  def destroy
    logger.info "#{current_user.email} signed out"
    if current_user.email == "coby@confreaks.com" && !current_user.is_admin?
      current_user.admin = true
      current_user.save
    end
    super
  end
end
