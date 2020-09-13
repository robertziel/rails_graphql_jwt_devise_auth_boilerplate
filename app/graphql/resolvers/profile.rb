module Resolvers
  class Profile < GraphQL::Schema::Resolver
    include ::GraphqlAuthenticationConcerns

    type Types::UserType, null: true
    description 'Returns the current user'

    def resolve
      authenticate_user!
      context[:current_user]
    end
  end
end
