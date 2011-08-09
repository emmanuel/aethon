require File.expand_path('../../../spec_helper', __FILE__)

describe Aethon::Client, '#search' do
  let(:connection)    { MiniTest::Mock.new }
  let(:options)       { Hash.new }
  let(:client)        { Aethon::Client.new(connection, {}, options) }
  let(:search_params) { Hash.new }

  subject { client.select(search_params) }

  describe 'collaboration' do
    it 'calls connection.select with `:params => search_params`' do
      connection.expect :select, {}, [ { :params => search_params } ]

      subject

      connection.verify
    end
  end

  describe 'logging' do
    let(:options)     { { :logger => logger } }
    let(:logger)      { MiniTest::Mock.new }

    it 'logs search_params' do
      connection.expect :select, {}, [ Hash ]
      # TODO: 1.8.7 emits warning about this regex
      logger.expect :debug, nil, [ /\A.*#{search_params.inspect}\Z/u ]

      subject

      logger.verify
    end
  end

end
