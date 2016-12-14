class Users
  def initialize(cipher = Cipher.new)
    @cipher = cipher
  end

  def save(user)
    return false unless user.valid?
    user.encrypted_password = cipher.encrypt(user.password)
    user.save
  end

  private

  attr_reader :cipher
end
