class BmailController < ApplicationController
  layout "main"

  def index
    @bmails = current_user.bmails
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