module Parsers
  class ShowParser
    def self.parse(hash)
      new(hash).parse
    end

    def initialize(hash)
      @hash = hash
    end

    def parse
      show.update(@hash)
    end

    private

    def show
      nil
    end
  end
end
