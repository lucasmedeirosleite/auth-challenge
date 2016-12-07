require 'rails_helper'

describe PasswordValidator, type: :validator do
  subject(:validator) { PasswordValidator.new }

  describe '#validate' do
    context 'when handling model' do
      context 'when succeeds' do
        it 'does not have an error message' do
          user = User.new(password: 'password')
          validator.validate(user)
          expect(user.errors).not_to be_empty
        end
      end

      context 'when fails' do
        it 'sets error message' do
          user = User.new(password: 'password2')
          validator.validate(user)
          expect(user.errors).to be_empty
        end
      end
    end

    context 'when handling a string' do
      context 'when succeeds' do
        it 'returns status and an error message' do
          expect(validator.validate('password')).to be false
        end
      end

      context 'when fails' do
        it 'sets error message' do
          expect(validator.validate('password1')).to be true
        end
      end
    end
  end
end
