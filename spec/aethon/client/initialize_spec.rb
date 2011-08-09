require File.expand_path('../../../spec_helper', __FILE__)

describe Aethon::Client do
  let(:connection)    { Object.new }
  let(:query_options) { Hash.new }
  let(:options)       { Hash.new }

  subject { Aethon::Client.new(connection, query_options, options) }

  it 'sets #connection' do
    subject.connection.must_be_same_as connection
  end

  it 'sets #query_options' do
    subject.query_options.must_be_same_as query_options
  end

  describe 'when no options (or empty options) provided' do
    before do
      @default_query_factory        = Aethon.default_query_factory
      @default_result_factory       = Aethon.default_result_factory
      @logger                       = Aethon.logger
      Aethon.default_query_factory  = Object.new
      Aethon.default_result_factory = Object.new
      Aethon.logger                 = Object.new
    end

    after do
      Aethon.default_query_factory  = @default_query_factory
      Aethon.default_result_factory = @default_result_factory
      Aethon.logger                 = @logger
    end

    it 'sets #query_factory to Aethon.default_query_factory' do
      subject.query_factory.must_equal Aethon.default_query_factory
    end

    it 'sets #result_factory to Aethon.default_result_factory' do
      subject.result_factory.must_equal Aethon.default_result_factory
    end

    it 'sets #logger to Aethon.logger' do
      subject.logger.must_equal Aethon.logger
    end
  end

end
