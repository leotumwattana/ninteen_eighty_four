class BailMailWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"

  def perform(bmail_id)
    bmail = Bmail.find(bmail_id)
    Bmailer.send_bmail(bmail).deliver
  end
end