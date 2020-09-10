require 'rails_helper'

describe Mutations::Profile do
  let(:user) { create(:user, first_name: 'A', last_name: 'B') }

  describe '#profile' do
    subject do
      graphql!['data']['profile']
    end

    before do
      prepare_query('{
        profile {
          name
        }
      }')
    end

    context `when there's no current user` do
      before do
        prepare_context({})
      end

      it 'is nil' do
        expect(subject).to eq(nil)
      end
    end

    context `when there's a current user` do
      before do
        prepare_context({ current_user: user })
      end

      it `shows the user's name` do
        expect(subject['name']).to eq('A B')
      end
    end
  end
end
