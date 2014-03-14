class SiteController < ApplicationController

  before_action :is_authenticated?

  def index
    @users = User.all.entries
  end

end
