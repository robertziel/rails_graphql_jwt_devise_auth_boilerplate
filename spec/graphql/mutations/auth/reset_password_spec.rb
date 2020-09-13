require 'rails_helper'

describe Mutations::Auth::ResetPassword do
  let(:query) do
    '
      mutation authResetPassword($password: String!, $passwordConfirmation: String!, $resetPasswordToken: String!){
        authResetPassword(password: $password, passwordConfirmation: $passwordConfirmation, resetPasswordToken: $resetPasswordToken)
      }
    '
  end
  let(:query_variables) do
    {
      password: new_password,
      password_confirmation: new_password,
      reset_password_token: user.reset_password_token
    }
  end
  let(:query_context) { {} }

  let!(:user) { create(:user, reset_password_token: SecureRandom.uuid, reset_password_sent_at: Time.zone.now) }
  let(:new_password) { 'new_password' }

  subject do
    graphql!['data']['authResetPassword']
  end

  let(:password) { SecureRandom.uuid }

  describe '#resolve' do
    context 'when no user exists with that token' do
      before do
        query_variables[:reset_password_token] = 'wrong_token'
      end

      it { expect(subject).to be false }
    end

    context 'when user exists' do
      before do
        allow(User).to receive(:with_reset_password_token) { user }
      end

      it { expect(subject).to be true }

      it 'calls send_reset_password_instructions on user' do
        expect(user).to receive(:reset_password).with(password, password)
        subject
      end

      context 'when password does NOT match confirmation' do
        before do
          query_variables[:password_confirmation] = 'wrong_password'
        end

        it { expect(subject).to be false }
      end
    end
  end
end
