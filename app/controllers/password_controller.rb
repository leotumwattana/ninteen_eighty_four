class PasswordController < ApplicationController

  def edit
    @user = User.find_by code: params[:code]
  end

  def update
    @user = User.find_by code: params[:code]

    if @user.update user_params
      render text: "Success"
    else
      render text: "Oopsies"
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end