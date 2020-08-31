module Mutations
  module User
    class TokenLogin < GraphQL::Schema::Mutation
      null true
      description 'JWT token login'
      payload_type Types::UserType

      def resolve
        context[:current_user]
      end
    end
  end
end
