require 'rails_helper'

describe Mutations::Profile::Update do
  let(:user_params) do
    {
      email: 'new@email.com',
      first_name: 'new_first_name',
      last_name: 'new_last_name',
      password: nil,
      password_confirmation: nil
    }
  end
  let(:current_user) { create :user }

  before do
    prepare_query('
      mutation profileUpdate($email: String, $firstName: String, $lastName: String, $password: String, $passwordConfirmation: String){
        profileUpdate(email: $email, firstName: $firstName, lastName: $lastName, password: $password, passwordConfirmation: $passwordConfirmation){
          success errors { message path }
        }
      }
    ')
  end

  subject do
    prepare_query_variables(user_params)
    graphql!['data']['profileUpdate']
  end

  let(:password) { SecureRandom.uuid }

  describe '#resolve' do
    context 'when no user exists' do
      before do
        prepare_context({})
      end

      it 'is nil' do
        expect(subject).to eq(nil)
      end
    end

    context 'when there\'s a matching user' do
      before do
        prepare_context({ current_user: current_user })
      end

      it 'updates email' do
        subject
        expect(current_user.reload.email).to eq user_params[:email]
      end

      context 'when password is updated' do
        before do
          user_params[:password] = 'new_password'
        end

        context 'when password matches confirmation' do
          before do
            user_params[:password_confirmation] = user_params[:password]
          end

          it 'returns user object' do
            expect(subject['errors']).to eq []
          end
        end

        context 'when password does NOT match confirmation' do
          before do
            user_params[:password_confirmation] = 'wrong_password_confirmation'
          end

          it 'returns error' do
            expect(has_attribute_error?(subject, :password_confirmation)).to be true
          end
        end
      end
    end
  end
end
