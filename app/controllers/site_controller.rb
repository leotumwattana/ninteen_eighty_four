class SiteController < ApplicationController

  def index
    @users = User.all.entries
  end

end
