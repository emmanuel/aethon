module Pyrois
  class Query
    class Options
      attr_reader :field_list
      attr_reader :query_fields
      attr_reader :filter_queries
      attr_reader :sort
      attr_reader :offset
      attr_reader :limit

      def initialize(options)
        @field_list     = options.fetch(:field_list,     nil)
        @query_fields   = options.fetch(:query_fields,   nil)
        @filter_queries = options.fetch(:filter_queries, nil)
        @sort           = options.fetch(:sort,           nil)
        @offset         = options.fetch(:offset,         nil)
        @limit          = options.fetch(:limit,          nil)
      end

      def merge(other)
        params.merge(other)
      end

      def params
        return @params if @params

        @params = {}

        @params[:fl]    = field_list     if field_list
        @params[:fq]    = filter_queries if filter_queries
        @params[:qf]    = query_fields   if query_fields
        @params[:sort]  = sort           if sort
        @params[:start] = offset         if offset
        @params[:rows]  = limit          if limit

        @params
      end

      def inspect
        %Q{<#{self.class} #{params.inspect}>}
      end

    end # class Options
  end # class Query
end # module Pyrois
