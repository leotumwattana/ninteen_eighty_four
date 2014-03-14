class SessionController < ApplicationController

  def new
    @messages = flash.map { |k, v| "#{k.capitalize}: #{v}" }.join ';'
  end

  def create
    @user = User.authenticate(params[:user][:email], params[:user][:password])
    if @user
      session[:user_id] = @user.id
      redirect_to root_url
    else
      # render text: "Who the funk are you"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, notice: "You've successfully logged out."
  end

end