module Pyrois
  class Query
    class Result

      attr_reader :result_set
      attr_reader :content

      def initialize(result_set, content)
        @result_set = result_set
        @content    = content
      end

      def id
        content.fetch('id', '')
      end

      def score
        content.fetch('score', '')
      end

      def match_percentage
        "#{normalized_score}%"
      end

      def normalized_score
        [(score * 2 * 100).to_i, 100].min
      end

      def to_s
        %Q{<#{self.class} score=#{score} id="#{id}">}
      end

      alias_method :inspect, :to_s

    private

      def method_missing(method, *args, &block)
        if content.include?(method.to_s)
          result_set.define_dynamic_method do
            content.fetch(method, '')
          end
        else
          super
        end
      end

    end # class Result
  end # class Query
end # module Pyrois
