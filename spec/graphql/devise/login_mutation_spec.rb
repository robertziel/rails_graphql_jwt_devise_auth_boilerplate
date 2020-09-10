require 'rails_helper'

RSpec.describe Mutations::User::Login do
  let(:query_variables) do
    {
      email: Faker::Internet.email,
      password: 'password'
    }
  end

  before do
    # reset vars and context
    prepare_context({})

    # set query
    prepare_query("
      mutation login($email: String!, $password: String!){
        login(email: $email, password: $password) {
          token
        }
      }
    ")
  end

  subject do
    prepare_query_variables(query_variables)
    graphql!['data']['login']
  end

  describe 'login' do
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
