module Utility
  module QueryFromHashBuilder
    def build_query_from_hash(params)
      uri = Addressable::URI.new
      uri.query_values = params
      uri.query
    end
  end
end