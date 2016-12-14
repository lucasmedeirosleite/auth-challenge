class User < ApplicationRecord
  attr_accessor :password

  validates :email, presence: true, email: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }, confirmation: true
  validates :password_confirmation, presence: true

  validates_with PasswordWordValidator
end
