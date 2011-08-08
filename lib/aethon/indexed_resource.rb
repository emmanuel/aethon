require 'virtus'

module Aethon
  class IndexedResource
    include Virtus

    attr_accessor :resource

    attribute :id,         String,        :default => proc { |d| [d.resource.class, d.resource.id].join('-') }
    attribute :class,      Constant,      :default => proc { |d| d.resource.class }
    attribute :ancestors,  ConstantArray, :default => proc { |d| d.resource.class.ancestors - ActiveRecord::Base.ancestors }

    attribute :score,      Float,         :default => nil

    def initialize(resource = nil, attributes = {})
      self.resource   = resource
      self.attributes = attributes
    end

    def indexed_attributes
      self.class.search_attribute_mapper.resource_indexed_attributes(self)
    end

    class << self
      attr_accessor :search_attribute_mapper

      def attribute(name, type, options = {})
        super(name, type, )
        alias_result_writer(name, type, options = {})
      end

      def alias_result_writer(name, type, options = {})
        indexed_name =
          search_attribute_mapper.map_document_attribute_definition(name, type, options)
        alias_method "#{indexed_name}=", "#{name}="
      end

    end

  end # class IndexedResource
end # module Aethon
