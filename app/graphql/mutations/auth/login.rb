module Mutations
  module Auth
    class Login < GraphQL::Schema::Mutation
      description 'Login for users'
      argument :email, String, required: true
      argument :password, String, required: true
      field :token, String, null: true

      def resolve(email:, password:)
        @email = email
        @password = password

        {
          token: valid_for_authentication? ? user.token : nil
        }
      end

      private

      def user
        @user ||= ::User.find_for_authentication(email: @email)
      end

      def valid_for_authentication?
        return false unless user

        user.valid_for_authentication? do
          user.valid_password?(@password)
        end
      end
    end
  end
end
