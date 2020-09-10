require 'rails_helper'

describe Mutations::Auth::SignUp do
  before do
    # reset vars and context
    prepare_query_variables(query_variables)
    prepare_context({})

    # set query
    prepare_query("
      mutation authSignUp($attributes: UserInput!){
        authSignUp(attributes: $attributes) {
          email
        }
      }
    ")
  end

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
