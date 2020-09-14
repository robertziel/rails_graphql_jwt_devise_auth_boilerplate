require 'rails_helper'

describe Mutations::Profile::Update do
  let(:query) do
    '
      mutation profileUpdate($email: String!, $firstName: String!, $lastName: String!, $password: String, $passwordConfirmation: String){
        profileUpdate(email: $email, firstName: $firstName, lastName: $lastName, password: $password, passwordConfirmation: $passwordConfirmation){
          success errors { message path }
        }
      }
    '
  end
  let(:query_variables) do
    {
      email: 'new@email.com',
      first_name: 'new_first_name',
      last_name: 'new_last_name',
      password: nil,
      password_confirmation: nil
    }
  end
  let(:query_context) { {} }

  subject do
    graphql!['data']['profileUpdate']
  end

  let(:password) { SecureRandom.uuid }

  describe '#resolve' do
    include_examples :graphql_authenticate_user

    it 'returns success true' do
      expect(subject['success']).to be true
    end

    it 'updates email' do
      subject
      expect(current_user.reload.email).to eq query_variables[:email]
    end

    context 'when password is updated' do
      before do
        query_variables[:password] = 'new_password'
      end

      context 'when password matches confirmation' do
        before do
          query_variables[:password_confirmation] = query_variables[:password]
        end

        it 'returns user object' do
          expect(subject['errors']).to eq []
        end
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
end
