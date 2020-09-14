require 'rails_helper'

describe Mutations::Auth::SignUp do
  let(:query) do
    '
      mutation authSignUp($email: String!, $firstName: String!, $lastName: String!, $password: String!, $passwordConfirmation: String!){
        authSignUp(email: $email, firstName: $firstName, lastName: $lastName, password: $password, passwordConfirmation: $passwordConfirmation){
          success errors { message path }
        }
      }
    '
  end
  let(:query_variables) { attributes_for(:user) }
  let(:query_context) { {} }

  describe '#resolve' do
    subject do
      graphql!['data']['authSignUp']
    end

    it 'creates new user' do
      expect { subject }.to change { User.count }.by(1)
    end

    it 'returns success true' do
      expect(subject['success']).to be true
    end

    context 'when password does NOT match confirmation' do
      before do
        query_variables[:password_confirmation] = 'wrong_password_confirmation'
      end

      it 'returns error' do
        expect(has_attribute_error?(subject, :password_confirmation)).to be true
      end

      it 'returns success false' do
        expect(subject['success']).to be false
      end
    end
  end
end
