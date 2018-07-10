module Parsers
  module Pathe
    class MovieParser < RecordParser
      def klass
        Movie
      end

      def initialize_by
        {
          external_id: @hash[:external_id],
          chain:       Chain::PATHE
        }
      end
    end
  end
end
