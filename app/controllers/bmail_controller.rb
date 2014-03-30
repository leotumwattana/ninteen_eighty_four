class BmailController < ApplicationController

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
  end

  def create
    bmail = Bmail.create(bmail_params)
    current_user.bmails << bmail
    current_user.save
    redirect_to bmail_index_path
  end

  def edit
    @bmail = Bmail.find_by(id: params[:id])
  end

  def update
    bmail = Bmail.find_by(id: params[:id])
    bmail.update_attributes(bmail_params)
    redirect_to bmail_index_path
  end

  def destroy
    bmail = Bmail.find(params[:id])
    bmail.destroy
    redirect_to root_url
  end

  def cancel
    @bmail = Bmail.find(params["id"])

    @bmail.advanced_alert_job_ids.each do |job_id|
      Sidekiq::Status.unschedule job_id
    end

    @bmail.scheduled_delivery_job_ids.each do |job_id|
      Sidekiq::Status.unschedule job_id
    end

    log_user_out_without_redirect

    render layout: "layouts/application"
  end

  private

  def bmail_params
    params.require(:bmail).permit(:title, :to, :content, :trigger_date, :time_zone)
  end

end