class BmailController < ApplicationController

  layout "main"

  before_action :is_authenticated?

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
  end

  def create
    bmail = Bmail.create(bmail_params)
    current_user.bmails << bmail
    current_user.save

    try_schedule_bmail(bmail)

    redirect_to bmail_index_path
  end

  def edit
    @bmail = Bmail.find_by(id: params[:id])
  end

  def update
    bmail = Bmail.find_by(id: params[:id])
    bmail.update_attributes(bmail_params)

    try_schedule_bmail(bmail)

    redirect_to bmail_index_path
  end

  def destroy
  end

  private

  def bmail_params
    params.require(:bmail).permit(:title, :to, :content, :trigger_date, :time_zone)
  end

  def try_schedule_bmail(bmail)
    if (not bmail.trigger_date.nil?) && (bmail.trigger_date > Time.now.gmtime)
      BailAlertWorker.perform_at(bmail.trigger_date, bmail.id.to_s)
    end
  end

end