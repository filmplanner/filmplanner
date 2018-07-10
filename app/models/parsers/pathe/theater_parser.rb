module Parsers
  module Pathe
    class TheaterParser < RecordParser
      def klass
        Theater
      end

      def initialize_by
        {
          id:     @hash[:id],
          chain:  Theater::PATHE
        }
      end
    end
  end
end
