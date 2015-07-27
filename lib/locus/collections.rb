require 'locus/collections/components'
require 'locus/collections/sites'

module Locus
  module Collections
    def self.classes
      [
        Locus::Components,
        Locus::Sites
      ]      
    end

    def self.find_class(name)
      self.classes.find(Proc.new { Locus::Collection }) { |c| c.collection_name == name }
    end
  end
end
