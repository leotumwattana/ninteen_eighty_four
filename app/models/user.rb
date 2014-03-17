require 'bcrypt'

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :password, :password_confirmation

  field :email, type: String
  field :wasabi, type: String
  field :fugu, type: String

  before_save :encrypt_password
  validates :email, presence: true, uniqueness: {case_sensitive: false}

  def self.authenticate(email, password)
    user = User.find_by email: email
    user if user and user.authenticate password
  end

  def authenticate(password)
    self.fugu == BCrypt::Engine.hash_secret(password, self.wasabi)
  end

  protected

  def encrypt_password
    if password.present?
      self.wasabi = BCrypt::Engine.generate_salt
      self.fugu = BCrypt::Engine.hash_secret(password, self.wasabi)
    end
  end

end