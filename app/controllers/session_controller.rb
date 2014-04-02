class SessionController < ApplicationController

  CHECK_EMAIL_PASSWORD_NOTICE = "Please check your email / password combination and try again."
  LOGGED_IN_NOTICE = "You are logged in"

  def new
    if current_user
      redirect_to bmails_url, notice: LOGGED_IN_NOTICE
    else
      redirect_to root_url, notice: CHECK_EMAIL_PASSWORD_NOTICE
    end
  end

  def create

    if params[:user][:password].blank?
      PasswordResetter.new(flash).reset_password(user_params)
    else
      return if log_user_in( UserAuthenticator.new(session, flash).authenticate_user(user_params) )
    end
    redirect_to root_url, alert: CHECK_EMAIL_PASSWORD_NOTICE
  end

  def destroy
    log_user_out
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end