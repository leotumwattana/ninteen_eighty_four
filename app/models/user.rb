require 'bcrypt'

PASSWORD_RESET_EXPIRES = 4

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :password, :password_confirmation

  field :email, type: String
  field :salt, type: String
  field :fugu, type: String
  field :code, type: String
  field :expires_at, type: Time

  before_save :set_random_password, :encrypt_password
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, confirmation: true

  def self.authenticate(email, password)
    user = User.find_by email: email
    user if user and user.authenticate password
  end

  def self.find_by_code code
    if user = User.find_by(code: code, :expires_at.gte => Time.now.gmtime)
      user.set_expiration
    end
    user
  end

  def authenticate(password)
    self.fugu == BCrypt::Engine.hash_secret(password, self.salt)
  end

  def set_reset_password
    self.code = SecureRandom.urlsafe_base64
    set_expiration
  end

  def set_expiration
    self.expires_at = PASSWORD_RESET_EXPIRES.hours.from_now
    self.save
  end

  def reset_password(params)
    if self.update_attributes(params)
      self.update_attributes(params.merge( code: nil, expires_at: nil ))
    end
  end

  protected

  def set_random_password
    if self.fugu.blank? and self.password.blank?
      self.salt = BCrypt::Engine.generate_salt
      self.fugu = BCrypt::Engine.hash_secret(SecureRandom.base64(32), self.salt)
    end
  end

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.fugu = BCrypt::Engine.hash_secret(password, self.salt)
    end
  end

end