module Types
  class MutationType < Types::BaseObject
    # Expose the mutation by binding a mutation from the module
    # into the field for this type
    field :create_user, mutation: Mutations::CreateUser
    field :signin_user, mutation: Mutations::SignInUser
    field :create_link, mutation: Mutations::CreateLink
    field :create_vote, mutation: Mutations::CreateVote
  end
end
