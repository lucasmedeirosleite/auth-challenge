require 'rails_helper'

describe Cipher do
  let(:password) { 'password' }

  describe '#encrypt' do
    it 'uses bcrypt' do
      expect(BCrypt::Password).to receive(:create).with(password)
      subject.encrypt(password)
    end
  end

  describe '#same?' do
    context 'when strings match' do
      let(:hashed_password) { '$2a$10$Pu27uiV2qwM8/EG/yzX.AO3jwYoQPAOELbutYFAQcxmchK6cvuzS6' }

      it 'tells passwords are the same' do
        expect(subject.same?(pure: password, encrypted: hashed_password)).to be true
      end
    end

    context 'when strings do not match' do
      let(:hashed_password) { '$2a$10$Pu27uiV2qwM8/EG/yzX.AO3jwYoQPAOELbutYFAQcxmchK6cvuzS7' }

      it 'tells passwords are not the same' do
        expect(subject.same?(pure: password, encrypted: hashed_password)).to be false
      end
    end
  end
end
