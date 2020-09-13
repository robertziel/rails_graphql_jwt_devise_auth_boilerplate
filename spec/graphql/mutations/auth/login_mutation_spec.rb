require 'rails_helper'

describe Mutations::Auth::Login do
  let(:query) do
    '
      mutation authLogin($email: String!, $password: String!){
        authLogin(email: $email, password: $password) {
          token
        }
      }
    '
  end
  let(:query_variables) do
    {
      email: Faker::Internet.email,
      password: 'password'
    }
  end
  let(:query_context) { {} }

  subject do
    graphql!['data']['authLogin']
  end

  describe '#resolve' do
    context 'when no user matching email exists' do
      it 'returns nil token' do
        expect(subject['token']).to eq(nil)
      end
    end

    context 'when user exists' do
      let!(:user) do
        create(:user, query_variables.merge(password_confirmation: query_variables[:password]))
      end

      context 'when user matches login credentials' do
        it 'returns new token' do
          expect(subject['token']).not_to eq nil
        end
      end

      context 'when user does not match login credentials' do
        before do
          query_variables[:password] = 'wrong_password'
        end

        it 'returns nil token' do
          expect(subject['token']).to eq(nil)
        end
      end
    end
  end
end
