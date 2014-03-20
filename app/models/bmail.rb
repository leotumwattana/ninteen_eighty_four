class Bmail

  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :to, type: Array
  field :content, type: String

  validates :title, presence: true
  validates :to, presence: true
  validates :content, presence: true

  alias _to= to=

  def to=(emails)
    self._to = emails.split(',').map { |e| e.strip.chomp }
  end

  def pretty_to
    self.to.join(', ')
  end

  private

  def split_emails(emails)
    emails.split(',').map { |e| e.strip }
  end

end