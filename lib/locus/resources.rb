require 'locus/resources/component'
require 'locus/resources/site'

module Locus
  class Resources
    def self.classes
      [
        Locus::Component,
        Locus::Site
      ]
    end

    def self.find_class(name)
      self.classes.find(Proc.new { Locus::Resource }) { |c| c.resource_name == name }
    end
  end
end
