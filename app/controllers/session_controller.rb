class SessionController < ApplicationController

  def new
    redirect_to bmail_index_url, notice: "You are logged in" if current_user
  end

  def create

    if params[:user][:password].blank?
      PasswordResetter.new(flash).reset_password(user_params)
    else
      return if log_user_in( UserAuthenticator.new(session, flash).authenticate_user(user_params) )
    end
    redirect_to root_url, alert: "Please check your email / password combination and try again."
  end

  def destroy
    log_user_out
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end