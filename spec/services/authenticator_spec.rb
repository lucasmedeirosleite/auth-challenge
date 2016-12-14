require 'rails_helper'

describe Authenticator, type: :service do
  describe '#call' do
    subject(:authenticator) { Authenticator.new(FakeCipher.new) }

    let(:email) { 'email@example.com' }
    let(:password) { 'password1' }
    let(:user) { FactoryGirl.build(:user, email: email, password: password, password_confirmation: password) }

    context 'when user with email was not found' do
      it 'fails' do
        expect(authenticator.call(email, 'password1')).to be false
      end
    end

    context 'when user password did not match' do
      let(:wrong_password) { 'password' }

      before { Users.new.save(user) }

      it 'fails' do
        expect(authenticator.call(user.email, wrong_password)).to be false
      end
    end

    context 'when user found and password match' do
      before { Users.new.save(user) }

      it 'succeeds' do
        expect(authenticator.call(user.email, password)).to be false
      end
    end

    class FakeCipher < Cipher
      def same?(pure:, encrypted:)
        pure == encrypted
      end
    end
  end
end
