class Bmailer < ActionMailer::Base

  NOTIFY_PREFIX = "Your BMail: "
  NOTIFY_SUFFIX = " is about to be delivered."

  def notify_user(bmail)
    @bmail = bmail
    user = bmail.user
    mail from: user.email, to: bmail.to_as_array, subject: NOTIFY_PREFIX + bmail.title + NOTIFY_SUFFIX
  end

  def send_bmail(bmail)

  end

end