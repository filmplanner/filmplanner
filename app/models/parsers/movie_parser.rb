module Parsers
  class MovieParser
    def self.parse(hash)
      new(hash).parse
    end

    def initialize(hash)
      @hash = hash
    end

    def parse
      movie if movie.update(attributes)
    end

    private

    def movie
      Movie.find_or_initialize_by(id: @hash[:id])
    end

    def attributes
      @hash.select { |key, _| Movie.column_names.include?(key.to_s) }
    end
  end
end
