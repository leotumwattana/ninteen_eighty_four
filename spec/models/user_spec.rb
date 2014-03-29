require 'spec_helper'

describe User do

  EMAIL_REGEX = /(?:[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/i

  before :each do
    @invalid_user = User.new
    @valid_user = User.new(
      email: 'kulio@gmail.com',
      salt: '1234',
      fugu: 'qwerty'
    )
  end

  it "is invalid without an email" do
    @valid_user.email = nil
    expect(@valid_user).to be_invalid
  end

  it "generates an encrypted password (can salt its own fugu)" do
    password = 123

    user = User.new email: 'kulio@gmail.com', password: password, password_confirmation: password
    user.instance_eval { encrypt_password }

    salt = user.salt
    salted_fugu = BCrypt::Engine.hash_secret(password, salt)

    expect(user.fugu).to eq(salted_fugu)
    expect(user.salt).not_to be_empty
  end

  it "is invalid without a salt" do
    @valid_user.salt = nil
    expect(@valid_user).to be_invalid
  end

  it "is invalid without a fugu" do
    @valid_user.fugu = nil
    expect(@valid_user).to be_invalid
  end

  it "is valid with a email, salt and fugu" do
    expect(@valid_user).to be_valid
  end

  describe "email" do
    it "is invalid with improper formatting" do
      @valid_user.email = "invalid_email_address"
      expect(@valid_user).to be_invalid
    end

    it "is valid with proper formatting" do
      expect(@valid_user).to be_valid
    end

    it "is case insensitive" do
      # @valid_user.save

      # u = User.find_by(email: "kulio@gmail.com")
      # expect(u).not_to be_nil

      # u = User.find_by(email: "KULIO@gmail.com")
      # expect(u).not_to be_nil

      # User.destroy_all
    end
  end

  describe "reset_password" do
    it "generates a reset code"
    it "generates an expiry date"
  end

  it "can be found by code"
end