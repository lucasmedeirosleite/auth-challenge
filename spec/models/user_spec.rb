require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(8) }

    describe 'email format' do
      it { is_expected.not_to allow_value('email').for(:email) }
      it { is_expected.not_to allow_value('email@').for(:email) }
      it { is_expected.to allow_value('email@example').for(:email) }
      it { is_expected.to allow_value('email@example.com').for(:email) }
    end

    describe 'uniqueness' do
      context 'when there is no user with email' do
        it 'creates a new user' do
          expect {
            User.create!(email: 'email@example.com', password: 'password123', password_confirmation: 'password123')
          }.to change { User.count }.by(1)
        end
      end

      context 'when there is a user with email' do
        let(:email) { 'email@example.com' }
        let(:password) { 'password123' }

        it 'does not save a new user' do
          FactoryGirl.create(:user, email: email, password: password, password_confirmation: password)

          expect {
            User.create!(email: email, password: 'password1', password_confirmation: 'password1')
          }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end

    describe 'password' do
      context "when password field does not have 'password' value" do
        it 'saves user' do
          expect {
            User.create!(email: 'email@example.com', password: 'password1', password_confirmation: 'password1')
          }.to change { User.count }.by(1)
        end
      end

      context "when password field has 'password' value" do
        it 'does not save user' do
          expect {
            User.create!(email: 'email@example.com', password: 'password', password_confirmation: 'password')
          }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end
end
