class UserAuthenticator

  AUTH_FAILED = "Please check your email and password."

  def initialize(session, flash)
    @session = session
    @flash = flash
  end

  def authenticate_user params
    unless @user = User.authenticate(params[:email], params[:password])
      @flash.now[:alert] = AUTH_FAILED
    end
    @user
  end

end