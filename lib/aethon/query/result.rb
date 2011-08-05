module Pyrois
  class Query
    class Result
      include Virtus

      attr_reader :result_set
      attr_reader :content

      attribute :id,    String
      attribute :score, Float


      def initialize(result_set, raw_result, logger = Pyrois.logger)
        @result_set = result_set
        @raw_result = raw_result
        @logger     = logger

        # TODO: pass raw_result through a mapper in order to turn Solr
        # dynamic field suffixes (*_text, *_s, *_sm, *_i, *_d, *_b, etc)
        # into unsuffixed attribute declarations of the appropriate type
        super(raw_result)
      end

      def match_percentage
        "#{normalized_score}%"
      end

      def normalized_score
        [(score * 2 * 100).to_i, 100].min
      end

      def to_s
        %Q{<#{self.class} id="#{id}" score=#{score}>}
      end

      alias_method :inspect, :to_s

    private

      # See TODO note in #initialize
      # 
      # def method_missing(method, *args, &block)
      #   attr_name = method.to_s.chomp("=")
      #   if raw_result.include?(attr_name)
      #     logger.debug "Adding attribute to #{self.class}: #{attr_name}"
      #     self.class.attribute attr_name, String
      #     self[attr_name] = args.first
      #   else
      #     super
      #   end
      # end

    end # class Result
  end # class Query
end # module Pyrois
