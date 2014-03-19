class UserNotifier < ActionMailer::Base

  RESET_READY ="[Collateral] Reset your credentials."
  RESET_SUCCESS = "[Collateral] Your password has been reset."

  default from: "Collateral <support@collateral.com>"

  def reset_password(user)
    @user = user
    mail to: @user.email, subject: RESET_READY
  end

  def password_was_reset(user)
    mail to: user.email, subject: RESET_SUCCESS
  end

end