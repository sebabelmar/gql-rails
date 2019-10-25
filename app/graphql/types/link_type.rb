module Types
  class LinkType < BaseObject
    field :id, ID, null: false
    field :url, String, null: false
    field :description, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: true

    field :votes, [Types::VoteType], null: false

    # Posted by will be cameled case
    # it can be nill since we added to the system later
    # the argument method => binds the field to a field in the model as resolver
    field :posted_by, UserType, null: true, method: :user
  end
end