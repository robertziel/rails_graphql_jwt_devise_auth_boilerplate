module Types
  class QueryType < BaseObject
    field :profile, resolver: Resolvers::Profile
  end
end
