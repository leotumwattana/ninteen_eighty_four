class SiteController < ApplicationController

  def index
    redirect_to bmails_url if current_user
  end

end
