module Types
  class LinksType < BaseObject
    field :links, [LinkType], null: false
  end
end