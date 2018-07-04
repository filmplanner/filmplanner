module Parsers
  class TheaterParser
    def self.parse(hash)
      new(hash).parse
    end

    def initialize(hash)
      @hash = hash
    end

    def parse
      theater.update(@hash)
    end

    private

    def theater
      Theater.find_or_initialize_by(id: @hash[:id])
    end
  end
end
