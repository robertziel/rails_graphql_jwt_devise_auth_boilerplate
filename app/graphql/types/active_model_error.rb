module Types
  class ActiveModelError < Types::BaseObject
    description 'Active model errors'

    field :message, String, null: false, description: 'A description of the error'
    field :path, [String], null: true, description: 'Which input value this error came from'
  end
end
