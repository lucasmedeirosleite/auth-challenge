require 'rails_helper'

describe Users, type: :repository do
  let(:repository) { Users.new }

  describe '#save' do
    before { repository.save(user) }

    context 'when validation does not succeeds' do
      let(:user) { User.new }

      it 'validates user without success' do
        expect(user.errors).not_to be_empty
      end

      it 'does not save user' do
        expect(repository.save(user)).to be false
      end
    end

    context 'when validation succeeds' do
      subject(:repository) { Users.new(cipher) }
      let(:cipher) { FakeCipher.new }

      let(:user) { FactoryGirl.build(:user, password: password, password_confirmation: password) }
      let(:password) { 'password1' }

      it 'validates user with success' do
        repository.save(user)
        expect(user.errors).to be_empty
      end

      it 'encrypts password' do
        expected_pass = cipher.encrypt(password)
        repository.save(user)
        expect(user.encrypted_password).to eq expected_pass
      end

      it 'saves user' do
        expect(repository.save(user)).to be true
        expect(User.count).to eq 1
      end

      class FakeCipher < Cipher
        def encrypt(password)
          password.reverse
        end
      end
    end
  end
end
