require 'search_object/plugin/graphql'


# TODO but not required LEARN WTF is going on here...
class Resolvers::LinksSearch
  include SearchObject.module(:graphql)
  
  # Starting point for search
  scope { Link.all }

  # returning values
  type types[Types::LinkType]

  # inline input type definition for the advance filter
  class LinkFilter < ::Types::BaseInputObject
    argument :OR, [self], required: false
    argument :description_contains, String, required: false
    argument :url_contains, String, required: false
  end

  # When filter is passed apply_filter would be called to narrow the scope
  option :filter, type: LinkFilter, with: :apply_filter

  def apply_filter(scope, value)
    branches = normalize_filters(value).reduce { |a, b| a.or(b) }
    scope.merge(branches)
  end

  def normalize_filters(value, branches=[])
    scope = Link.all
    scope = scope.where('description LIKE ?', "%#{value[:description_contains]}%") if value[:description_contains]
    scope = scope.where('url LIKE ?', "%#{value[:url_contains]}%") if value[:url_contains]

    branches << scope

    value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) } if value[:OR].present?

    branches
  end
end