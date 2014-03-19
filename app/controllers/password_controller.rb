class PasswordController < ApplicationController

  LINK_EXPIRED = "Your reset link has expired. Please generate a new one"
  RESET_SUCCESS = "Your password has been reset successfully."

  def edit
    unless @user = User.find_by_code(params[:code])
      redirect_to login_url, notice: LINK_EXPIRED
    end
  end

  def update
    if @user = User.find_by_code(params[:code])
    # if user if found
      if params[:user][:password].blank?

        @user.errors.add(:password, "can't be blank")
        flash.now[:alert] = @user.errors
        render :edit

      elsif @user.reset_password( user_params )

        UserNotifier.password_was_reset(@user).deliver
        log_user_in( @user, RESET_SUCCESS )

      else

        flash.now[:alert] = @user.errors
        render :edit

      end

    # otherwise show a message not found
    else

      redirect_to root_url, notice: "No code found."

    end

  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end