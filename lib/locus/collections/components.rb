require 'locus/collection'

module Locus
  class Components < Collection
    def self.collection_name
      "components" 
    end

    def self.resource_name
      "component"
    end
  end
end
