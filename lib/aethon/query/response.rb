require 'pyrois'
require 'pyrois/query/result_set'

module Pyrois
  class Query
    class Response
      include Enumerable

      attr_reader :response
      attr_reader :results

      def initialize(response, result_factory = Pyrois.default_result_factory)
        @response       = response
        @result_factory = result_factory
      end

      def each
        results.each { |result| yield result }

        self
      end

      def results
        @results ||= Query::ResultSet.new(raw_results, result_factory)
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
end # module Pyrois
