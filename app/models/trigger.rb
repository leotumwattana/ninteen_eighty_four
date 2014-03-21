class Trigger

  include Mongoid::Document
  include Mongoid::Timestamps

  field :start, type: DateTime
  field :repeat, type: Integer
  field :interval, type: Integer # in minutes?
  field :disarm, type: Integer
  field :grace, type: Integer, default: 60

  belongs_to :bmail

  validates :start, presence: true
  validates :disarm, presence: true
end