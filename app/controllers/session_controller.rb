class SessionController < ApplicationController

  def new
  end

  def create
    @user = User.authenticate(params[:user][:email], params[:user][:password])
    if @user
      session[:user_id] = @user.id
      redirect_to root_url
    else
      render text: "Who the funk are you"
    end
  end

  def destroy
    session[:user_id] = nil
    render text: "Log the user out."
  end

end