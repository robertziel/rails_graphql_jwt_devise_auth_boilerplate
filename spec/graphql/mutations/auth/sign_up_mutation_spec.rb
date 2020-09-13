require 'rails_helper'

describe Mutations::Auth::SignUp do
  let(:query) do
    '
      mutation authSignUp($attributes: UserInput!){
        authSignUp(attributes: $attributes) {
          email
        }
      }
    '
  end
  let(:query_variables) { {} }
  let(:query_context) { {} }

  describe '#resolve' do
    let(:user) { build(:user) }
    let(:query_variables) do
      {
        attributes: {
          email: user.email,
          password: user.password,
          passwordConfirmation: user.password_confirmation,
          firstName: user.first_name,
          lastName: user.last_name
        }
      }
    end

    subject do
      graphql!['data']['authSignUp']
    end

    it 'returns user object' do
      expect(subject['email']).to eq(user.email)
    end
  end
end
