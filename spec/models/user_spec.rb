require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) } # email is required
    it { is_expected.to validate_presence_of(:password) } # password is required
    it { is_expected.to validate_confirmation_of(:password) } # must have a confirmation field for password
    it { is_expected.to validate_length_of(:password).is_at_least(8) } # password must have at least 8 characters

    describe 'email format' do
      it { is_expected.not_to allow_value('email').for(:email) } # invalid email format
      it { is_expected.not_to allow_value('email@').for(:email) } # invalid email format
      it { is_expected.to allow_value('email@example').for(:email) } # valid email format
      it { is_expected.to allow_value('email@example.com').for(:email) } # valid email format
    end

    describe 'uniqueness' do
      # It creates a new user with a valid info in case there is no user with the desired email
      context 'when there is no user with email' do
        it 'creates a new user' do
          expect {
            User.create!(email: 'email@example.com', password: 'password123', password_confirmation: 'password123')
          }.to change { User.count }.by(1)
        end
      end

      # It does not create a new user with the same email of an existent user email
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
      # It creates a new user when password value is not 'password' and its value is aligned with the validation requirements
      context "when password field does not have 'password' value" do
        it 'saves user' do
          expect {
            User.create!(email: 'email@example.com', password: 'password1', password_confirmation: 'password1')
          }.to change { User.count }.by(1)
        end
      end

      # It does not create an user when he/she has a password with the value 'password'
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
