require 'bcrypt'

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String
  field :saffron, type: String
  field :fugu, type: String
end