class BMailController < ApplicationController

  def index
    @bmails = BMail.all.entries
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end

end