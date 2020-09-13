module GraphqlAuthenticationConcerns
  def authenticate_user!
    return if context[:current_user]

    raise GraphQL::ExecutionError.new(
      'authentication failed',
      extensions: { code: GraphQL::Errors::AUTHENTICATION_ERROR }
    )
  end
end
