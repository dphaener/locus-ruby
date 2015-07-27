require 'locus/collection'

module Locus
  class Sites < Collection
    def self.collection_name
      "sites"
    end

    def self.resource_name
      "site"
    end
  end
end
