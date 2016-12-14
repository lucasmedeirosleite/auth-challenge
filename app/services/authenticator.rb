require 'auth'

class Authenticator
  include Auth::Service

  def initialize(cipher = Cipher.new, password_validator = PasswordWordValidator.new)
    @cipher = cipher
    @password_validator = password_validator
  end

  def call(email, password)
    return false unless password_validator.validate(password)
    user = User.where(email: email).first
    return false unless user.present?
    cipher.same?(pure: password, encrypted: user.encrypted_password)
  end

  private

  attr_reader :cipher, :password_validator
end
