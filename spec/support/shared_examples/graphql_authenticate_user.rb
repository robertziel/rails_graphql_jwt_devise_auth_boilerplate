shared_examples :graphql_authenticate_user do |user|
  let(:current_user) { user || create(:user) }

  context 'when not authenticated' do
    before do
      query_context[:current_user] = nil
    end

    it 'returns authentication error' do
      result = graphql!['errors'].any? do |error|
        error['extensions']['code'] == GraphQL::Errors::AUTHENTICATION_ERROR
      end
      expect(result).to eq(true)
    end
  end

  before do
    query_context[:current_user] = current_user
  end
end
