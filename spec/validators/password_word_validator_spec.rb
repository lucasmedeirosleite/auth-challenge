require 'rails_helper'

# Validator which is used on both User model and SessionsController#create
describe PasswordWordValidator, type: :validator do
  subject(:validator) { PasswordWordValidator.new }

  describe '#validate' do

    # When it's been used inside the User model
    context 'when handling model' do

      # Checks if password field has value 'password'
      context 'when fails' do
        it 'has an error message' do
          user = User.new(password: 'password')
          validator.validate(user)
          expect(user.errors).not_to be_empty
        end
      end

      # Checks if password field does not have value 'password'
      context 'when succeeds' do
        it 'does not have an error message' do
          user = User.new(password: 'password2')
          validator.validate(user)
          expect(user.errors).to be_empty
        end
      end
    end

    # When it's checking a string
    context 'when handling a string' do

      # It returns false when passed string is 'password'
      context 'when fails' do
        it { expect(validator.validate('password')).to be false }
      end

      # It returns true when passed string is not 'password'
      context 'when succeeds' do
        it { expect(validator.validate('password1')).to be true }
      end
    end
  end
end
