module Parsers
  class DateTimeParser
    def self.parse(date, time)
      new(date, time).parse
    end

    def initialize(date, time)
      @date = date
      @time = time
    end

    def parse
      @date.to_datetime + Time.zone.parse(@time).seconds_since_midnight.seconds
    end
  end
end
