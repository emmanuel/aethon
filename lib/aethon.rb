require 'stringio'
require 'rsolr'
require 'pyrois/version'

module Pyrois
  extend self

  attr_accessor :logger
  attr_accessor :solr_url
  attr_accessor :default_query_options
  attr_accessor :default_result_factory

  attr_writer :connection
  attr_writer :client

  self.default_query_options = {
    :field_list     => "*,score",
    :query_fields   => nil,
    :filter_queries => nil,
    :sort           => "score desc",
    :offset         => 0,
    :limit          => 30,
  }

  # TODO: eliminate rsolr dependency
  def connection
    @connection ||= solr_url ? RSolr.connect(:url => solr_url) : nil
  end

  def client
    @client ||= connection ? Client.new(connection, default_query_options, logger) : nil
  end

  self.logger = StringIO.new("")

end
