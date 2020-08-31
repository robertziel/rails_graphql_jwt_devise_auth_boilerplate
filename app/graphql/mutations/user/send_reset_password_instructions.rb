module Mutations
  module User
    class SendResetPasswordInstructions < GraphQL::Schema::Mutation
      null true
      description 'Send password reset instructions to users email'
      argument :email, String, required: true
      payload_type Boolean

      def resolve(email:)
        user = ::User.find_by_email(email)
        return true unless user

        user.send_reset_password_instructions
        true
      end
    end
  end
end
