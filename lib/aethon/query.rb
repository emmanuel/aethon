require 'aethon'
require 'aethon/query/response'

module Aethon
  class Query
    include Enumerable

    attr_reader :client
    attr_reader :options
    attr_reader :response_factory
    attr_reader :result_factory
    attr_accessor :logger

    attr_accessor :field_list

    def initialize(client, query_string, options = {})
      @client  = client
      @query   = query_string
      @options = Query::Options.new(client.query_options)

      @response_factory = options.fetch(:response_factory, Aethon.default_response_factory)
      @result_factory   = options.fetch(:result_factory,   Aethon.default_result_factory)
      @logger           = options.fetch(:logger,           Aethon.logger)

      @response = nil
    end

    def each
      response.each { |result| yield result }
    end

    def results
      response.results
    end

    def response
      @response ||= response_factory.new(client.select(params), result_factory)
    end

    def loaded?
      !!@response
    end

    def clear
      @response = nil
    end

    def params
      options.merge(:q => query)
    end

    def query
      blank_query? ? "*:*" : @query
    end

    # TODO: remove activesupport dependency
    def blank_query?
      @query.blank?
    end

    def inspect
      %Q{<#{self.class} url="#{client.url}" query="#{query}" options=#{options.inspect}>}
    end

  end # class Query
end # module Aethon
