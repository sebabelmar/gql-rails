=begin
{
  allLinks(
    filter: {
      urlContains: "google"
      OR: {
        descriptionContains: "yeah"
        urlContains: "banana"
      }
    },
    first: 2,
    skip: 1
  ){
    description
    url
  }
}

{
  "data": {
    "allLinks": [
      {
        "description": "yeah ggl",
        "url": "google.com"
      },
      {
        "description": "yeah ggl",
        "url": "google.com"
      }
    ]
  }
} 
=end


module Types
  class QueryType < Types::BaseObject
    # here the allLinks query and its resolver
    # Queries are represented as fields
    # all_links is automatically camelcased to allLinks
    # field :all_links, [LinkType], null: false
    field :all_links, [LinkType], function: Resolvers::LinksSearch

    # This is the resolever method, and its invoked when allLinks is call
    # its return value is passed down to the next level if any as breth first
    # def all_links
    #   Link.all
    # end
  end
end
