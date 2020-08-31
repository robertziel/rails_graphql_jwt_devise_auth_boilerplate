require 'rails_helper'

RSpec.describe GraphqlController, type: :controller do
  login_user # access current user with @current_user

  let(:expected_response_body) do
    { 'data' => { 'me' => { 'email' => @current_user.email } } }
  end

  describe 'execute' do
    it 'responds with a valid graphql response' do
      post :execute, params: {
        'query' => '{ me { email } }'
      }
      expect(response_body).to eq(expected_response_body)
    end

    context 'when wrong query params given' do
      it 'should return with errors' do
        post :execute, params: {
          'query' => '{ wrong { email } }'
        }
        expect(response_body['errors']).to_not be nil
      end
    end

    # TODO: better vairales test
    context 'when using String variables' do
      it 'should return with valid graphql response' do
        post :execute, params: {
          'query' => '{ me { email } }',
          'variables' => '{ "Test": "Me" }'
        }
        expect(response_body).to eq(expected_response_body)
      end
    end

    context 'when using empty String variables' do
      it 'should return with valid graphql response' do
        post :execute, params: {
          'query' => '{ me { email } }',
          'variables' => ''
        }
        expect(response_body).to eq(expected_response_body)
      end
    end

    context 'when using Hash variables' do
      it 'should return with valid graphql response' do
        post :execute, params: {
          'query' => '{ me { email } }',
          'variables' => { 'Test' => 'Me' }
        }
        expect(response_body).to eq(expected_response_body)
      end
    end

    context 'when variables are invalid' do
      subject do
        post :execute, params: {
          'query' => '{ me { email } }',
          'variables' => 12
        }
      end

      it 'should raise argument error' do
        expect { subject }.to raise_error(ArgumentError)
      end

      context 'environment is development' do
        it 'should call the local logger' do
          Rails.env = 'development'
          expect { subject }.not_to raise_error
          Rails.env = 'test'
        end
      end
    end
  end
end
