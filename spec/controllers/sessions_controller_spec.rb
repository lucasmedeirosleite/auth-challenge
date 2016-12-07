require 'rails_helper'

describe SessionsController, type: :controller do
  describe 'POST #create' do
    before { @request.env["devise.mapping"] = Devise.mappings[:user] }

    context 'when authentication fails' do
      before do
        process :create, method: :post, params: { user: { email: email, password: password } }
      end

      context 'when no email passed' do
        let(:email) { '' }
        let(:password) { 'password123' }

        it 'does not authorize' do
          expect(response).to be_unauthorized
        end

        it 'sets error message' do
          expect(flash[:alert]).to eq 'E-mail is required'
        end
      end

      context 'when email with invalid format' do
        let(:password) { 'password123' }
        let(:email) { 'invalid_email' }

        it 'does not authorize' do
          expect(response).to be_unauthorized
        end

        it 'sets error message' do
          expect(flash[:alert]).to eq 'Invalid e-mail'
        end
      end

      context 'when password has minimum of 8 characters' do
        let(:password) { 'pass' }
        let(:email) { 'email@example.com' }

        it 'does not authorize' do
          expect(response).to be_unauthorized
        end

        it 'sets error message' do
          expect(flash[:alert]).to eq 'Invalid password'
        end
      end

      context "when password field has the value of 'password'" do
        let(:password) { 'password' }
        let(:email) { 'email@example.com' }

        it 'does not authorize' do
          expect(response).to be_unauthorized
        end

        it 'sets error message' do
          expect(flash[:alert]).to eq 'Invalid password'
        end
      end
    end

    context 'when authentication succeeds' do
      let(:email)    { 'email@example.com' }
      let(:password) { 'password123' }

      before do
        FactoryGirl.create(:user, email: email, password: password)
        process :create, method: :post, params: { user: { email: email, password: password } }
      end

      it 'redirects' do
        expect(response).to be_redirect
      end

      it 'sets success message' do
        expect(flash[:notice]).to eq 'Signed in successfully'
      end
    end
  end
end
