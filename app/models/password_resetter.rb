class PasswordResetter

  SUCCESS = "We'll send you an email with instructions"
  NOTIFIER_ERROR = "Oppssss...how embarrasing, we couldn't send the reset password email."
  RESET_ERROR = "Sorry, we were unable to reset your password."
  NO_USER = "Please check your email address and try again."

  def initialize flash
    @flash = flash
  end

  def reset_password params
    @user = User.find_by(email: params[:email])

    if @user
      set_code_and_email_reset_password
    else
      @flash.now[:alert] = NO_USER
    end
  end

  def update_password(user, params)
    if user.reset_password( params )
      # success
      UserNotifier.password_was_reset(user).deliver
    else
      # fail
      @flash.now[:alert] = user.errors
      nil
    end
  end

  def set_code_and_email_reset_password
    if @user.set_reset_password
      begin
        UserNotifier.reset_password(@user).deliver
        @flash.now[:notice] = SUCCESS
      rescue
        @flash.now[:alert] = NOTIFIER_ERROR
      end
    else
      @flash.now[:alert] = RESET_ERROR
    end
  end
end