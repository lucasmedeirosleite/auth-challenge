class Users
  def initialize(encrypter = Encrypter)
    @encrypter = encrypter
  end

  def save(user)
    return false unless user.valid?
    user.encrypted_password = encrypter.call(user.password)
    user.save
  end

  private

  attr_reader :encrypter
end
