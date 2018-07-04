module Parsers
  class ScheduleParser
    def self.parse(hash)
      new(hash).parse
    end

    def initialize(hash)
      @hash = hash
    end

    def parse
    end
  end
end
