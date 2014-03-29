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
    current_user.bmails << Bmail.new(bmail_params)
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
  end

  private

  def bmail_params
    params.require(:bmail).permit(:title, :to, :content)
  end

end