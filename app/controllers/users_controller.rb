class UsersController < ApplicationController

  CREATE_FAILED = "We were unable to create your account."
  UPDATE_FAILED = "Oppss...how embarrassing. We're not able to update your account information at this time."

  def index
    @users = User.all.entries
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    if @user = User.create(user_params)
      # success
      log_user_in(@user)
      # redirect_to root_url
    else
      # fail
      flash.now[:alert] = CREATE_FAILED
      render :new
    end
    # binding.pry
  end

  def edit
    @user = User.find_by(email: params[:email])
  end

  def update
    @user = User.find_by(email: params[:email])
    if @user.update_attributes(user_params)
      # success
      log_user_in(@user)
      redirect_to root_url
    else
      # fail
      flash.now[:alert] = UPDATE_FAILED
    end
  end

  def destroy
    user = User.find_by(email: params[:email])
    user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end