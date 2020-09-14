module Mutations
  module Profile
    class Update < GraphQL::Schema::Mutation
      include ::GraphqlActiveModelConcerns
      include ::GraphqlAuthenticationConcerns

      description 'Update user'
      argument :email, String, required: true
      argument :first_name, String, required: true
      argument :last_name, String, required: true
      argument :password, String, required: false
      argument :password_confirmation, String, required: false
      field :success, Boolean, null: false
      field :errors, [Types::ActiveModelError], null: false

      def resolve(email:, first_name:, last_name:, password:, password_confirmation:)
        authenticate_user!
        user = context[:current_user]
        user_params = {
          email: email,
          first_name: first_name,
          last_name: last_name,
          password: password,
          password_confirmation: password_confirmation
        }

        if user_params[:password].blank?
          user_params.except!(:password, :password_confirmation)
        else
          user_params[:password] = user_params[:password] || ''
          user_params[:password_confirmation] = user_params[:password_confirmation] || ''
        end

        if user.update(user_params)
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
