class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def facebook
    create
  end

  def twitter
    create
  end

  def github
    create
  end

  def open_id
    create
  end
  
  ##
  # this method is called by /auth/:provider/callback from all the
  # oauth providers of this app.  So it is the auth lookup/create code
  def create
    omniauth = request.env["omniauth.auth"]

    authentication = Authentication.find_by_provider_and_uid(
                                                         omniauth['provider'],
                                                         omniauth['uid']
                                                             )

    if authentication
      # an authentication for this provider and user already exists
      # check to see if there is an entry for this event
      check_event_entry authentication

      sign_in_and_redirect(:user, authentication.user)

    elsif current_user
      current_user.authentications.create(:provider => omniauth['provider'],
                                          :uid => omniauth['uid'])
      flash[:notice] = "Authentication with #{omniauth['provider']} was successful."
      redirect_to authentications_url
    else
      # New user
      user = User.new

      user.apply_omniauth(omniauth)
      if user.save
        check_event_entry user.authentications[0]
        sign_in_and_redirect(:user, user)
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    redirect_to authentications_url, :notice => "Successfully destroyed authentication."
  end

  def failure
  end
  
protected

  def handle_unverified_request
    true
  end
end
