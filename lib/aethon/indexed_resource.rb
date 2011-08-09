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

    @index_boosts = {}
    @query_boosts = {}

    class << self
      attr_reader :index_boosts
      attr_reader :query_boosts
      attr_accessor :search_attribute_mapper

      def attribute(name, type, options = {}, &block)
        attribute_options = options.select do |k,v|
          Virtus::Attribute.options.include?(k)
        end

        attribute_options.fetch(:default) do
          attribute_options[:default] = proc do |instance, attribute|
            instance.resource.instance_eval(&block) if instance.resource
          end
        end if block

        super(name, type, attribute_options)

        mapper = search_attribute_mapper
        indexed_name = mapper.map_document_attribute_definition(name, type, options)

        capture_index_options(indexed_name, options)
        alias_result_writer(indexed_name, name)
      end

      def capture_index_options(indexed_name, options = {})
        index_boost = options.fetch(:index_boost, nil)
        index_boosts[name] = index_boost if index_boost

        query_boost = options.fetch(:query_boost, nil)
        query_boosts[name] = query_boost if query_boost
      end

      def alias_result_writer(indexed_name, name)
        alias_method "#{indexed_name}=", "#{name}="
      end

    end

  end # class IndexedResource
end # module Aethon
