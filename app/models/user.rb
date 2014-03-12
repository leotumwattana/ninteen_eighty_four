require 'bcrypt'

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :password, :password_confirmation

  field :email, type: String
  field :wasabi, type: String
  field :fugu, type: String

  before_save :encrypt_password

  def encrypt_password
    if password.present?
      self.wasabi = BCrypt::Engine.generate_salt
      self.fugu = BCrypt::Engine.hash_secret(password, self.wasabi)
    end
  end

end