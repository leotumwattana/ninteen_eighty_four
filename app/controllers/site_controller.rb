class SiteController < ApplicationController

  def index
    redirect_to bmail_index_url if current_user
  end

end
