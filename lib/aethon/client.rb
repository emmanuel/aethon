require 'aethon'

module Aethon
  class Client

    attr_reader :connection
    attr_reader :query_options
    attr_reader :query_factory
    attr_reader :result_factory
    attr_accessor :logger

    def initialize(connection, query_options = {}, options = {})
      @connection     = connection
      @query_options  = query_options

      @query_factory  = options.fetch(:query_factory,  Aethon.default_query_factory)
      @result_factory = options.fetch(:result_factory, Aethon.default_result_factory)
      @logger         = options.fetch(:logger,         Aethon.logger)
    end

    def query(query_string)
      query_factory.new(self, query_string, query_options, result_factory)
    end

    def select(search_params)
      logger.debug "SELECTING FROM SEARCH INDEX: #{search_params.inspect}"
      connection.select(:params => search_params)
    end

    def add(add_params)
      logger.debug "ADDING TO SEARCH INDEX: #{add_params}"
      connection.add(add_params)
    end

    def delete(query_string)
      logger.debug "DELETING FROM SEARCH INDEX: #{query_string}"
      connection.delete_by_query [query_string]
    end

    def commit
      logger.debug "COMMITTING SEARCH INDEX"
      connection.commit     # commit_attributes: {}
      connection.optimize   # optimize_attributes: {}
    end

    def purge
      delete('*:*')
    end

    def url
      connection.url
    end

    def inspect
      %Q{<#{self.class} url="#{url.to_s}" query_options=#{query_options.inspect}>}
    end

  end
end