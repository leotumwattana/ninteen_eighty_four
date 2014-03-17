class UserNotifier < ActionMailer::Base

  default from: "Collateral <support@collateral.com>"

  def reset_password(user)
    @user = user
    mail to: @user.email, subject: "[Collateral] Reset your credentials"
  end

  def password_was_reset(user)

  end
end