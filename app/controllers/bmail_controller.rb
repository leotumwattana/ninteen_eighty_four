class BmailController < ApplicationController

  def index
    @bmails = Bmail.all.entries
  end

  def show
    id = params[:id]
    @bmail = Bmail.find_by(id: id)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

end