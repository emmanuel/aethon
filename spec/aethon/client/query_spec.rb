require File.expand_path('../../../spec_helper', __FILE__)

describe Aethon::Client, '#query' do
  let(:connection)    { MiniTest::Mock.new }
  let(:query_options) { Hash.new }
  let(:options)       { Hash.new }
  let(:client)        { Aethon::Client.new(connection, query_options, options) }

  subject { client.query(query_string) }

  describe 'when query is "foo"' do
    let(:query_string)  { 'foo' }
    let(:query_factory) { MiniTest::Mock.new }
    let(:options)       { { :query_factory => query_factory } }
    let(:expected_options) do
      { :result_factory => Aethon::Query::Result, :logger => Aethon.logger }
    end

    it 'calls query_factory.new with self, query_string, and options' do
      connection.expect :url, 'http://foo'
      query_factory.expect :new, :return_value, [ client, query_string, expected_options ]

      subject

      query_factory.verify
    end
  end

end
