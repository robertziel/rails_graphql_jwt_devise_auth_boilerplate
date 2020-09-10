require 'rails_helper'

describe Mutations::Auth::SendResetPasswordInstructions do
  before do
    prepare_query("
      mutation authSendResetPasswordInstructions($email: String!){
        authSendResetPasswordInstructions(email: $email)
      }
    ")
  end

  describe '#resolve' do
    subject do
      prepare_context({})
      prepare_query_variables(query_variables)
      graphql!['data']['authSendResetPasswordInstructions']
    end

    context 'when no user exists' do
      let(:query_variables) do
        {
          email: Faker::Internet.email
        }
      end

      it { expect(subject).to be true }
    end

    context 'when user exists' do
      let!(:user) { create(:user) }
      let(:query_variables) do
        {
          email: user.email
        }
      end

      it { expect(subject).to be true }

      it 'calls send_reset_password_instructions on user' do
        allow_any_instance_of(User).to receive(:send_reset_password_instructions)
        subject
      end
    end
  end
end
