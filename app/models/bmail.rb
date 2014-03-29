class Bmail

  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :to, type: Array
  field :content, type: String
  field :trigger_date, type: DateTime

  belongs_to :user, dependent: :nullify

  scope :active, -> { where(:trigger_date.ne => nil).order_by(:trigger_date.desc) }
  scope :pending, -> { where(:trigger_date => nil).order_by(:created_at.desc) }
  scope :sent, -> { where(:trigger_date.lte => Time.now, :trigger_date.ne => nil).order_by(:trigger_date.asc) }

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

  def split_emails(emails)
    emails.split(',').map { |e| e.strip }
  end

end