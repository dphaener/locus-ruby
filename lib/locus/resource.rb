module Locus
  class Resource
    attr_reader :attributes, :items

    def initialize(raw_data = {})
      @attributes = raw_data.dup.freeze if raw_data
      @items = parse_items
    end

    def self.resource_name
      "resource"
    end

    def attribute_keys
      return items.keys.map(&:to_sym) if items.is_a?(Hash)
    end

    def singular?
      true
    end

    def parse_items
      if attributes.is_a?(Hash)
        {}.tap do |hsh|
          attributes.each do |key, value|
            hsh[key] = value
          end
        end
      else
        attributes
      end
    end

    def respond_to?(method_name, include_private = false)
      attribute_keys.include?(method_name) || super
    end

    def method_missing(method_name, *args, &block)
      attribute_keys.include?(method_name) ? items[method_name.to_sym] : super
    end
  end
end
