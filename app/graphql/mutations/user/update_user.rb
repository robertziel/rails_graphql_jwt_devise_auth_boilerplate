module Mutations
  module User
    class UpdateUser < GraphQL::Schema::Mutation

      null true
      description 'Update user'
      argument :email, String, required: false
      argument :first_name, String, required: false
      argument :last_name, String, required: false
      argument :password, String, required: false
      argument :passwordConfirmation, String, required: false
      field :success, Boolean, null: false
      field :errors, [Types::ActiveModelError], null: false

      def resolve(email:, first_name:, last_name:, password:, password_confirmation:)
        user = context[:current_user]
        return nil unless user

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

      def errors(user)
        user.errors.messages.map do |key, messages|
          path = [:attributes, key.to_s.camelize(:lower)]
          {
            path: path,
            message: messages.join(', ')
          }
        end
      end
    end
  end
end
