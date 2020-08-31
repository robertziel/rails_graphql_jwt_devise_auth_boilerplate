module Mutations
  module User
    class UpdateUser < GraphQL::Schema::Mutation

      null true
      description 'Update user'
      argument :password, String, required: false
      argument :passwordConfirmation, String, required: false
      payload_type Types::UserType

      def resolve(
        password: current_user_password,
        password_confirmation: current_user_password_confirmation
      )
        user = context[:current_user]
        return nil unless user

        user.update!(
          password: password,
          password_confirmation: password_confirmation
        )
        user
      end

      private

      def current_user_password
        context[:current_user] ? context[:current_user].password : ''
      end

      def current_user_password_confirmation
        context[:current_user] ? context[:current_user].password_confirmation : ''
      end
    end
  end
end
