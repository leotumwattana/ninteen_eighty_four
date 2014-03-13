class SessionController < ApplicationController

  def new
    render text: "Display the log in form."
  end

  def create
    render text: "Log the user in."
  end

  def destroy
    render text: "Log the user out."
  end

end