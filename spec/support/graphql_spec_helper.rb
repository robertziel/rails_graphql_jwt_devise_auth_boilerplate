module GraphqlSpecHelper
  def graphql!
    GraphqlSchema.execute(
      @query,
      context: @context,
      variables: @variables
    )
  end

  def prepare_query_variables(variables)
    @variables = variables.deep_transform_keys do |key|
      key.to_s.camelize :lower
    end
  end

  def prepare_context(context)
    @context = context
  end

  def prepare_query(query)
    @query = query
  end

  def has_attribute_error?(result, attribute)
    result['errors'].any? do |error|
      attribute_camelized = attribute.to_s.camelize(:lower)
      error['path'].join('_') == "attributes_#{attribute_camelized}"
    end
  end

  def response_body
    JSON.parse(response.body)
  end
end
