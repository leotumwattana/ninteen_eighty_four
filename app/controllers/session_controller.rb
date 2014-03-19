class SessionController < ApplicationController

  def new
    redirect_to root_url, notice: "You are logged in" if current_user
  end

  def create
    if params[:user][:password].blank?
      PasswordResetter.new(flash).reset_password(user_params)
    else
      UserAuthenticator.new(session, flash).authenticate_user(user_params)
    end
    session[:user_id] ? redirect_to(root_url) : render(:new)
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, notice: "You've successfully logged out."
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end