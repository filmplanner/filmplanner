module Parsers
  module Pathe
    class TheaterParser < RecordParser
      def klass
        Theater
      end

      def initialize_by
        {
          id: @hash[:id]
        }
      end
    end
  end
end
