module Types
  class QueryType < Types::BaseObject
    # here the allLinks query and its resolver
    # Queries are represented as fields
    # all_links is automatically camelcased to allLinks
    field :all_links, [LinkType], null: false

    # This is the resolever method, and its invoked when allLinks is call
    # its return value is passed down to the next level if any as breth first
    def all_links
      Link.all
    end
  end
end
