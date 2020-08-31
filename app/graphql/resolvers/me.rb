module Resolvers
  class Me < GraphQL::Schema::Resolver
    type Types::UserType, null: true
    description 'Returns the current user'

    def resolve
      context[:current_user]
    end
  end
end
