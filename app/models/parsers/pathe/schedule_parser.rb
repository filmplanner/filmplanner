module Parsers
  module Pathe
    class ScheduleParser
      def self.parse(hash)
        new(hash).parse
      end

      def initialize(hash)
        @hash = hash
      end

      def parse
        @hash[:movies].each do |movie_hash|
          movie = Parsers::Pathe::MovieParser.parse(movie_hash)

          movie_hash[:theaters].each do |theater_hash|
            theater = Theater.find_by(name: theater_hash[:name])

            theater_hash[:shows].each do |show_hash|
              Parsers::Pathe::ShowParser.parse(show_hash, movie: movie, theater: theater)
            end
          end
        end
      end
    end
  end
end
