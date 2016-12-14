require 'auth'

class Authenticator
  include Auth::Service

  def initialize(cipher = Cipher.new)
    @cipher = cipher
  end

  def call(email, password)
    user = User.where(email: email).first
    return false unless user.present?
    cipher.same?(pure: password, encrypted: user.encrypted_password)
  end

  private

  attr_reader :cipher
end
