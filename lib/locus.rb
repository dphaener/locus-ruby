require 'locus/version'
require 'locus/client'
require 'locus/response'

module Locus
  class << self
    attr_accessor :token

    def configure
      yield self
      validate
    end

    def validate
      raise AttributeMissingError, "You must include a token" unless token
    end
  end
end
