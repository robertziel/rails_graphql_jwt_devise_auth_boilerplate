require 'rails_helper'

describe Mutations::Profile do
  let(:query) do
    '{
      profile {
        name
      }
    }'
  end
  let(:query_variables) { {} }
  let(:query_context) { {} }

  describe '#profile' do
    subject do
      graphql!['data']['profile']
    end

    include_examples :graphql_authenticate_user

    it `shows the user's name` do
      expect(subject['name']).to eq current_user.name
    end
  end
end
