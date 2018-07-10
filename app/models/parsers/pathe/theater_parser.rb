module Parsers
  module Pathe
    class TheaterParser < RecordParser
      def klass
        Theater
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
