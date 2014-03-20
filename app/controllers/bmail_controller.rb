class BmailController < ApplicationController
  layout "main"

  def index
    @bmails = Bmail.all.entries
  end

  def show
    @bmail = Bmail.find_by(id: params[:id])
  end

  def new
  end

  def create
    Bmail.create(bmail_params)
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