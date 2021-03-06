require 'rails_helper'

describe AuthenticationController, type: :controller do

  # Testing the action that is called when the user tries to login
  describe 'POST #sign_in' do
    context 'when authentication fails' do
      before do
        process :sign_in, method: :post, params: { user: { email: email, password: password } }
      end

      # Trying to login with invalid information
      # No email, but with password
      context 'when no email passed' do
        let(:email) { '' }
        let(:password) { 'password123' }

        it 'sets error message' do
          expect(flash[:alert]).not_to be_nil
        end
      end

      # Trying to login with invalid information
      # Email in a invalid format and with password
      context 'when email with invalid format' do
        let(:password) { 'password123' }
        let(:email) { 'invalid_email' }

        it 'sets error message' do
          expect(flash[:alert]).not_to be_nil
        end
      end

      # Trying to login with invalid information
      # With valid email but with a password with lenght < 8
      context 'when password has minimum of 8 characters' do
        let(:password) { 'pass' }
        let(:email) { 'email@example.com' }

        it 'sets error message' do
          expect(flash[:alert]).not_to be_nil
        end
      end

      # Trying to login with invalid information
      # With valid email but with a password with value 'password'
      context "when password field has the value of 'password'" do
        let(:password) { 'password' }
        let(:email) { 'email@example.com' }

        it 'sets error message' do
          expect(flash[:alert]).not_to be_nil
        end
      end
    end

    # Testing the success flow
    # With a valid email and password from an existing user
    context 'when authentication succeeds' do
      let(:email)    { 'email@example.com' }
      let(:password) { 'password123' }
      let(:user) { FactoryGirl.build(:user, email: email, password: password, password_confirmation: password) }

      before do
        Users.new.save(user)
        process :sign_in, method: :post, params: { user: { email: email, password: password } }
      end

      it 'redirects' do
        expect(response).to be_redirect
      end

      it 'sets success message' do
        expect(flash[:notice]).not_to be_nil
      end

      it 'sets user id' do
        expect(session[:user_id]).to eq user.id
      end
    end
  end
end
