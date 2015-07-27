require 'locus/collections'
require 'locus/resources'

module Locus
  class Response
    attr_reader :status, :body, :members, :resource_name, :raw_body

    def initialize(status, body, resource_name = "resource")
      @status = status
      @resource_name = resource_name
      @raw_body = body.clone.freeze
      @body = body
      @members = parse_members
    end

    def success?
      (200..299).include?(status)
    end

    def respond_to?(method_name, include_private = false)
      resource_name.to_sym == method_name || "#{resource_name}s".to_sym == method_name || method_name == "errors".to_sym || super
    end

    def method_missing(method_name, *args, &block)
      return super unless resource_name.to_sym == method_name || "#{resource_name}s".to_sym == method_name || method_name == "errors".to_sym
      members
    end

  private

    def parse_members
      klass = if body.is_a?(Array)
        Locus::Collections.find_class("#{resource_name}s")
      else
        Locus::Resources.find_class(resource_name)
      end

      klass.new(body)
    end
  end
end
