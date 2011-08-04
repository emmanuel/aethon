require 'pyrois'

module Pyrois
  class Query
    class ResultSet
      include Enumerable

      attr_reader :raw_results
      attr_accessor :result_factory
      attr_accessor :logger

      def initialize(raw_results, result_factory = Pyrois.default_result_factory, logger = Pyrois.logger)
        @raw_results    = raw_results
        @result_factory = Class.new(result_factory)
        @logger         = logger

        @results        = []
        @instantiated   = false
      end

      def each
        if instantiated?
          @results.each { |result| yield result }
        else
          instantiate { |result| yield result }
        end

        self
      end

      def results
        instantiate unless instantiated?

        @results
      end

      def instantiate
        return self if instantiated?

        raw_results.each do |raw_result|
          result = result_factory.new(self, raw_result, logger)
          @results << result
          yield result if block_given?
        end
        instantiated!

        self
      end

      def instantiated?
        !!@instantiated
      end

      def inspect
        "<#{self.class} results=#{results}>"
      end

    private

      def instantiated!
        @instantiated = true
      end

    end # class ResultSet
  end # class Query
end # module Pyrois
