require 'rails_helper'

RSpec.describe GraphqlController, type: :controller do
  let(:variables) { '' }
  let(:current_user) { create(:user) }
  let(:expected_response_body) do
    { 'data' => { 'profile' => { 'email' => current_user.email } } }
  end

  subject do
    post :execute, params: {
      query: query,
      variables: variables
    }
  end

  before do
    login_user(current_user)
  end

  describe 'execute' do
    context 'when valid query params given' do
      let(:query) { '{ profile { email } }' }

      it 'responds with a valid graphql response' do
        subject
        expect(response_body).to eq(expected_response_body)
      end

      context 'when using String variables' do
        let(:variables) { '{ "Test": "profile" }' }

        it 'returns with valid graphql response' do
          subject
          expect(response_body).to eq(expected_response_body)
        end
      end

      context 'when using empty String variables' do
        let(:variables) { '' }

        it 'returns with valid graphql response' do
          subject
          expect(response_body).to eq(expected_response_body)
        end
      end

      context 'when using Hash variables' do
        let(:variables) { { 'Test' => 'profile' } }

        it 'returns with valid graphql response' do
          subject
          expect(response_body).to eq(expected_response_body)
        end
      end

      context 'when variables are invalid' do
        let(:variables) { 12 }

        it 'should raise arguprofilent error' do
          expect { subject }.to raise_error(ArgumentError)
        end

        context 'environment is development' do
          it 'calls the local logger' do
            Rails.env = 'development'
            expect { subject }.not_to raise_error
            Rails.env = 'test'
          end
        end
      end
    end

    context 'when wrong query params given' do
      let(:query) { '{ wrong { email } }' }

      it 'returns with errors' do
        subject
        expect(response_body['errors']).to_not be nil
      end
    end
  end
end
