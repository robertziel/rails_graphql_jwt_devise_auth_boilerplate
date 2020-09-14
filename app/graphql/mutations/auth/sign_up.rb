module Mutations
  module Auth
    class SignUp < GraphQL::Schema::Mutation
      include ::GraphqlActiveModelConcerns

      description 'Sign up for users'
      argument :email, String, required: false
      argument :first_name, String, required: false
      argument :last_name, String, required: false
      argument :password, String, required: false
      argument :passwordConfirmation, String, required: false
      field :success, Boolean, null: false
      field :errors, [Types::ActiveModelError], null: false

      def resolve(email:, first_name:, last_name:, password:, password_confirmation:)
        user_params = {
          email: email,
          first_name: first_name,
          last_name: last_name,
          password: password,
          password_confirmation: password_confirmation
        }

        user = ::User.new(user_params)

        if user.save
          success_response
        else
          failed_response(user)
        end
      end

      private

      def success_response
        {
          success: true,
          errors: []
        }
      end

      def failed_response(user)
        {
          success: false,
          errors: errors(user)
        }
      end
    end
  end
end
