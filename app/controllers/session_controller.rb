class SessionController < ApplicationController

  def new
    redirect_to root_url, notice: "You are logged in" if current_user
  end

  def create
    user = User.find_by(email: params[:user][:email])
    password = params[:user][:password]

    if user and password.blank?
      user.set_reset_password
      UserNotifier.reset_password(user).deliver
      flash.now[:notice] = "We'll send you an email..."
      render :new
    elsif user and user.authenticate(password)
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash.now[:alert] = "Please check your email and password."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, notice: "You've successfully logged out."
  end

end