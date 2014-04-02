class BmailNotificationWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"

  def perform(bmail_id)
    bmail = Bmail.find(bmail_id)
    Bmailer.notify_user(bmail).deliver
  end
end