module GraphqlActiveModelConcerns
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
