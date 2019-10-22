=begin
mutation {
  createVote(linkId:"2") {
    link {
      description
    }
    user {
      name
    }
  }
}

{
  "data": {
    "createVote": {
      "link": {
        "description": "Awesome GraphQL Client"
      },
      "user": {
        "name": "seba belmar"
      }
    }
  }
}
=end


module Mutations
  class CreateVote < BaseMutation
    argument :link_id, ID, required: false

    type Types::VoteType

    def resolve(link_id: nil)
      Vote.create!(
        link: Link.find(link_id),
        user: context[:current_user]
      )
    
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end