class SessionController < ApplicationController

  def new
    render text: "Display the log in form."
  end

  def create
    # render text: "Yo! #{params[:user][:email]} ... All your passwords are belong to us: #{params[:user][:password]}"
    render text: User.authenticate(params[:user][:email], params[:user][:password])
  end

  def destroy
    render text: "Log the user out."
  end

end