module Mutations
  class CreateLink < BaseMutation

    # Arguments that the mutaiton can take
    # and will be passed to the resolver
    argument :description, String, required: true
    argument :url, String, required: true

    # Returning type after mutation succeed
    type Types::LinkType

    # Here the resolver to the mutation
    def resolve(description: nil, url: nil)
      Link.create!(
        description: description,
        url: url,
        user: context[:current_user]
      )
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end 