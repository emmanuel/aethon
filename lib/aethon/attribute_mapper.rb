module Aethon
  class AttributeMapper

    def map_document_attribute(name, type)
      
    end

    def map_result_attribute(name)
      
    end


    class DefaultSolrDynamicFields < AttributeMapper

      TYPES = {
        Virtus::Attribute::String      => "s",
        Virtus::Attribute::Text        => "text",
        Virtus::Attribute::Integer     => "i",
        Virtus::Attribute::Float       => "f",
        # TODO: How to deal with multi-valued String, Integer, Float, etc
        # Perhaps implement them as custom Virtus::Attribute subclasses? ex:
        # Aethon::Attribute::StringArray => "sm",
        # Aethon::Attribute::MultiString => "sm",
        # TODO: How to deal with TrieDateField, TrieStringField, etc.
        # Perhaps implement them as custom Virtus::Attribute subclasses? ex:
        # Aethon::Attribute::TrieString => "strie",
      }
      SUFFIXES = TYPES.invert

      def self.type_suffix(type)
        TYPES[type]
      end

      def self.suffix_type(suffix)
        SUFFIXES[suffix]
      end

      def map_document_attribute_definition(name, type, options = {})
        suffix = self.class.type_suffix(type)
        stored = options.fetch(:stored, nil)
        [name, suffix, stored].compact.join('_')
      end

      def map_result_attribute(name)
        
      end

      def resource_indexed_attributes(resource)
        indexed_attributes = {}

        attributes.each do |attribute|
          name, type, options = attribute.name, attribute.type, attribute.options
          indexed_name =
            search_attribute_mapper.map_document_attribute_definition(name, type, options)

          indexed_attributes[indexed_name] = attribute.get(resource)
        end

        indexed_attributes
      end

    end # class DynamicFieldsDefault

  end # class AttributeMapper
end # module Aethon
