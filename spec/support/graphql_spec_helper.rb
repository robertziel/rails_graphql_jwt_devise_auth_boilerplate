module GraphqlSpecHelper
  # run after let(:query), let(:query_variables), let(:query_context) is set
  def graphql!
    prepare_request
    GraphqlSchema.execute(
      @query,
      context: @context,
      variables: @variables
    )
  end

  def prepare_request
    prepare_query(query)
    prepare_query_variables(query_variables)
    prepare_context(query_context)
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
    return false if result.blank?

    result['errors'].any? do |error|
      attribute_camelized = attribute.to_s.camelize(:lower)
      error['path'].join('_') == "attributes_#{attribute_camelized}"
    end
  end
end
