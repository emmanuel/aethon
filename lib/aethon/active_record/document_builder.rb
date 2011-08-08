module Aethon
  module ActiveRecord
    class DocumentBuilder < ::BasicObject
      # a DSL evaluation context for building an indexing and result container
      # document for indexed ActiveRecord instances

      def self.build(&block)
        new(&block)._build
      end

      attr_reader :definition
      attr_reader :document_class

      def initialize(&block)
        @definition = block
        @document_class = Class.new(Aethon::IndexedResource)
        # TODO: deal with custom primary key
      end

      def _build
        instance_eval(&definition)
      end

    end # class DocumentBuilder
  end # module ActiveRecord
end # module Aethon
