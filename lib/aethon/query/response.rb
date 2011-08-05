require 'aethon'
require 'aethon/query/result_set'

module Aethon
  class Query
    class Response
      include Enumerable

      attr_reader :response
      attr_reader :result_set_factory
      attr_reader :result_factory
      attr_reader :results
      attr_reader :logger

      def initialize(response, options = {})
        @response           = response
        @result_set_factory = options.fetch(:result_set_factory, Aethon.default_result_set_factory)
        @result_factory     = options.fetch(:result_factory,     Aethon.default_result_factory)
        @logger             = options.fetch(:logger,             Aethon.logger)
        @results            = nil
      end

      def each
        results.each { |result| yield result }

        self
      end

      def results
        @results ||= result_set_factory.new(raw_results, result_factory)
      end

      def result_count
        raw_response.fetch('numFound', 0)
      end

      def highest_score
        raw_response.fetch('maxScore', 0)
      end

      def time
        raw_header.fetch('QTime', 0)
      end

      def query
        params.fetch('q', '')
      end

      def offset
        params.fetch('start', 0).to_i
      end

      def per_page
        params.fetch('rows', 0).to_i
      end

      def sort
        params.fetch('sort', '')
      end

      def params
        raw_header.fetch('params', {})
      end

      def raw_results
        raw_response.fetch('docs', [])
      end

      def raw_header
        response.fetch('responseHeader', {})
      end

      def raw_response
        response.fetch('response', {})
      end

      def inspect
        %Q{<#{self.class} query="#{query}" time=#{time} sort="#{sort}" offset=#{offset} limit=#{limit} result_count=#{result_count}>}
      end

    end # class Response
  end # class Query
end # module Aethon
