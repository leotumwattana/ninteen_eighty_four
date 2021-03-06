class BmailsController < ApplicationController

  layout "main"

  before_action :is_authenticated?, except: [:cancel]

  def index
    @active_bmails = current_user.bmails.active
    @pending_bmails = current_user.bmails.pending
  end

  def sent
    @sent_bmails = current_user.bmails.sent
    render :sent
  end

  def show
    @bmail = Bmail.find_by(id: params[:id])
  end

  def new
    @bmail = Bmail.new
  end

  def create
    bmail = Bmail.create(bmail_params)
    current_user.bmails << bmail
    redirect_to bmails_path
  end

  def edit
    @bmail = Bmail.find_by(id: params[:id])
  end

  def update
    bmail = Bmail.find_by(id: params[:id])
    bmail.update_attributes(bmail_params)
    redirect_to bmails_path
  end

  def destroy
    bmail = Bmail.find(params[:id])
    bmail.destroy
    redirect_to bmails_path
  end

  def cancel
    @bmail = Bmail.find(params["id"])
    @bmail.unschedule

    log_user_out_without_redirect
    render layout: "layouts/application"
  end

  private

  def bmail_params
    params.require(:bmail).permit(:title, :to, :content, :trigger_date, :time_zone)
  end

end