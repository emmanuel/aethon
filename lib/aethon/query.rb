require 'aethon'

module Aethon
  class Query
    include Enumerable

    attr_reader :client
    attr_reader :query
    attr_reader :result_factory

    attr_accessor :field_list

    def initialize(client, query_string, options = {}, result_factory = Aethon.default_result_factory, logger = Aethon.logger)
      @client         = client
      @query          = query_string
      @options        = Query::Options.new(options)
      @result_factory = result_factory
      @logger         = logger

      @response     = nil
    end

    def loaded?
      !!@response
    end

    def clear
      @response = nil
    end

    def each
      response.each { |result| yield result }
    end

    def results
      response.results
    end

    def response
      @response ||= Query::Response.new(client.select(params), result_factory)
    end

    # TODO: remove activesupport dependency
    def query
      @query.blank? ? "*:*" : @query
    end

    def params
      options.merge(:q => query)
    end

    def inspect
      %Q{<#{self.class} url="#{client.url}" query="#{query}" options=#{options.inspect}>}
    end

  end # class Query
end # module Aethon

require 'aethon/query/response'
