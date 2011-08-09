require 'logger'
require 'stringio'
require 'rsolr'
require 'aethon/version'

module Aethon
  extend self

  attr_accessor :logger
  attr_accessor :solr_url
  attr_accessor :default_query_options

  attr_writer :default_query_factory
  attr_writer :default_response_factory
  attr_writer :default_result_factory

  attr_writer :connection
  attr_writer :client

  self.logger = Logger.new(StringIO.new(""))

  self.default_query_options = {
    :field_list     => "*,score",
    :query_fields   => nil,
    :filter_queries => nil,
    :sort           => "score desc",
    :offset         => 0,
    :limit          => 30,
  }

  def default_query_factory
    @default_query_factory ||= Query
  end

  def default_response_factory
    @default_response_factory ||= Query::Response
  end

  def default_result_factory
    @default_result_factory ||= Query::Result
  end

  # TODO: eliminate rsolr dependency
  def connection
    @connection ||= solr_url ? RSolr.connect(:url => solr_url) : nil
  end

  def client
    @client ||= connection ? Client.new(connection, default_query_options, :logger => logger) : nil
  end

end

require 'aethon/client'
require 'aethon/query'
require 'aethon/query/options'
require 'aethon/query/response'
require 'aethon/query/result_set'
require 'aethon/query/result'
