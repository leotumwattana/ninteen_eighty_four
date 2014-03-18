class PasswordController < ApplicationController

  def edit
    @user = User.find_by code: params[:code]
  end

  def update
    @user = User.find_by code: params[:code]

    if @user
    # if user if found
      if params[:user][:password].blank?
        @user.errors.add(:password, "This field can't be blank")
      elsif @user.update_attributes user_params
        render text: "Success!" and return
      else
        render text: "Failure!"
      end

    # otherwise show a message not found
    else
      render text: "No code found"
    end

  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end