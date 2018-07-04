module Parsers
  class MovieParser
    def self.parse(hash)
      new(hash).parse
    end

    def initialize(hash)
      @hash = hash
    end

    def parse
      movie.update(@hash)
    end

    private

    def theater
      nil
    end
  end
end
