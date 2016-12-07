class PasswordValidator < ActiveModel::Validator
  def validate(value)
    return handle_string(value) if value.kind_of?(String)
    handle_model(value)
  end

  private
  INVALID_MESSAGE = "Password cannot contain 'password' value".freeze

  def handle_string(text)
    return false if text == 'password'
    true
  end

  def handle_model(record)
    if record.password == 'password'
      record.errors.add(:email, INVALID_MESSAGE)
    end
  end
end
