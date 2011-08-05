require File.expand_path('../../../spec_helper', __FILE__)
require 'aethon'

describe Aethon::Client do
  def query_options; {}; end
  def options;       {}; end
  def client; Aethon::Client.new(@connection, query_options, options); end

  before { @connection = MiniTest::Mock.new }

  describe 'when query is "foo"' do
    before do
      @query_string   = "foo"
      @query_factory  = MiniTest::Mock.new
      @result_factory = MiniTest::Mock.new
    end

    def options
      { :query_factory => @query_factory, :result_factory => @result_factory }
    end

    it "calls query_factory.new with self, query_string, query_options, and result_factory" do
      client = self.client
      @connection.expect :url, "http://foo"
      # @result_factory.expect :inspect, :return_value
      @query_factory.expect :new, :return_value, [ client, @query_string, query_options, @result_factory ]

      client.query(@query_string)

      @query_factory.verify
    end
  end

end
