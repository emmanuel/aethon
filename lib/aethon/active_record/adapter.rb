require 'aethon/active_record/document_builder'

module Aethon
  module ActiveRecord
    module Adapter

      attr_reader :search_result_factory

      def searchable(&block)
        @search_result_factory = DocumentBuilder.build(&block)
      end

    end # module ActiveRecord
  end # module OrmAdapter
end # module Aethon
