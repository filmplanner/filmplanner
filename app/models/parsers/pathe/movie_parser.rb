module Parsers
  module Pathe
    class MovieParser < RecordParser
      def klass
        Movie
      end

      def initialize_by
        {
          id: @hash[:id]
        }
      end
    end
  end
end
