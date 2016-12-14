require 'auth'
require 'bcrypt'

class Cipher
  def encrypt(password)
    BCrypt::Password.create(password)
  end

  def same?(pure:, encrypted:)
    BCrypt::Password.new(encrypted) == pure
  end
end
