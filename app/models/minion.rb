class Minion
  include Sidekiq::Worker
  sidekiq_options queue: "high"

  def perform(scheduled_at)
    puts "Minion #{scheduled_at}: performing task at: #{Time.now}"
  end
end