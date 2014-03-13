class SessionController < ApplicationController

  def new
    render text: "Display the log in form."
  end

  def create
    @user = User.authenticate(params[:user][:email], params[:user][:password])

    if @user
      render text: "#{@user.email} is in the house yo!"
    else
      render text: "Who the funk are you"
    end
  end

  def destroy
    render text: "Log the user out."
  end

end