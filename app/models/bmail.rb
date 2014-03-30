class Bmail

  ACTIVE_MONGOID_JS_QUERY = "(this.trigger_date - (this.time_zone * 60 * 60 * 1000)) > new Date().getTime()"
  SENT_MONGOID_JS_QUERY = "(this.trigger_date - (this.time_zone * 60 * 60 * 1000)) <= new Date().getTime()"
  ADVANCED_ALERT_PERIOD = 1.hour

  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :to, type: Array
  field :content, type: String
  field :trigger_date, type: DateTime
  field :scheduled_job_id, type: String
  field :time_zone, type: Integer, default: 0

  belongs_to :user, dependent: :nullify

  after_save :schedule_advanced_alert, :schedule_delivery

  scope :active, -> { where(:trigger_date.ne => nil).where(ACTIVE_MONGOID_JS_QUERY).desc(:trigger_date) }
  scope :pending, -> { where(:trigger_date => nil).desc(:created_at) }
  scope :sent, -> { where(:trigger_date.ne => nil).where(SENT_MONGOID_JS_QUERY).desc(:trigger_date) }

  validates :title, presence: true
  validates :to, presence: true
  validates :content, presence: true

  alias _to= to=
  alias to_as_array to

  def to=(emails)
    self._to = emails.split(',').map { |e| e.strip.chomp }
  end

  def to
    self.to_as_array.join(', ')
  end

  def pretty_to
    self.to.join(', ')
  end

  private

  def schedule_advanced_alert
    unless trigger_date.nil?
      BailAlertWorker.perform_at(trigger_date - time_zone.hours - ADVANCED_ALERT_PERIOD, id.to_s)
    end
  end

  def schedule_delivery
    unless trigger_date.nil?
      schedule_id = BailMailWorker.perform_at(trigger_date - time_zone.hours, id.to_s)
      puts "THIS IS THE SCHEDULE ID: " + schedule_id.to_s
    end
  end

  def split_emails(emails)
    emails.split(',').map { |e| e.strip }
  end

end