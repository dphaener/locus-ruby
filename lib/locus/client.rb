require 'faraday'
require 'faraday_middleware'
require 'json'
require 'locus/response'
require 'locus/client/component_data'
require 'locus/client/site_data'
require 'locus/errors'

module Locus
  class Client
    include ComponentData
    include SiteData

    attr_accessor :token 

    def initialize
      yield(self) if block_given?
      raise MissingAttributeError, "You must declare the token attribute" unless token
    end

    def content_type
      "application/json"
    end

    def get(url, resource_name, options = {})
      build_response(resource_name) do
        connection.get do |req|
          req.url url
          req.params = options
        end
      end
    end

    def post(url, resource_name, options = {})
      build_response(resource_name) do
        connection.post do |req|
          req.url url
          req.body = options.to_json
        end
      end
    end

    def put(url, resource_name, options = {})
      build_response(resource_name) do
        connection.put do |req|
          req.url url
          req.body = options.to_json
        end
      end
    end

    def delete(url, resource_name, options = {})
      build_response(resource_name) do
        connection.delete do |req|
          req.url url
          req.body = options.to_json
        end
      end
    end

    def build_response(resource_name, &block)
      response = yield
      resource = response_successful?(response) ? resource_name : "error"

      response_object = Locus::Response.new(response.status, response.body, resource)

      if resource_name == "token" && response.success?
        set_token(response_object.token.value)
      end

      response_object
    end

    def connection
      @connect ||= Faraday.new do |f|
        f.adapter :net_http
        f.url_prefix = "https://api.locusenergy.com/v3/"
        f.headers["User-Agent"] = "Locus Ruby v#{Locus::VERSION}"
        f.headers["Content-Type"] = content_type
        f.headers["Accept"] = "*/*"
        f.headers["Authorization"] = "Bearer #{token}"
        f.response :json, content_type: /\bjson$/
      end
    end
  end
end
