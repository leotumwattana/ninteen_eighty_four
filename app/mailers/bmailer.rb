class Bmailer < ActionMailer::Base

  NOTIFY_PREFIX = "Your BMail: "
  NOTIFY_SUFFIX = " is about to be delivered."

  default from: "BMail <support@collateral.com>"

  def notify_user(bmail)
    @bmail = bmail
    user = bmail.user
    mail to: user.email, subject: NOTIFY_PREFIX + bmail.title + NOTIFY_SUFFIX
  end

  def send_bmail(bmail)
    @bmail = bmail
    user = bmail.user
    mail from: user.email, to: bmail.to_as_array, subject: bmail.title
  end

end