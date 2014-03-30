class UserNotifier < ActionMailer::Base

  RESET_READY ="[BMail] Reset your credentials."
  RESET_SUCCESS = "[BMail] Your password has been reset."

  default from: "BMail <support@collateral.com>"

  def reset_password(user)
    @user = user
    mail to: @user.email, subject: RESET_READY
  end

  def password_was_reset(user)
    mail to: user.email, subject: RESET_SUCCESS
  end

end