module Parsers
  class ShowParser
    def self.parse(hash, movie, theater)
      new(hash, movie, theater).parse
    end

    def initialize(hash, movie, theater)
      @hash     = hash
      @movie    = movie
      @theater  = theater
    end

    def parse
      show if show.update(attributes)
    end

    private

    def show
      Show.find_or_initialize_by(
        movie:    @movie,
        theater:  @theater,
        date:     @hash[:date],
        start:    start_datetime,
        end:      end_datetime
      )
    end

    def attributes
      @hash.select { |key, _| Show.column_names.include?(key.to_s) }
    end

    def start_datetime
      date_with_time(@hash[:date], @hash[:start])
    end

    def end_datetime
      end_datetime = date_with_time(@hash[:date], @hash[:end])

      end_datetime < start_datetime ? end_datetime + 1.day : end_datetime
    end

    def date_with_time(date, time)
      date.to_datetime + Time.zone.parse(time).seconds_since_midnight.seconds
    end
  end
end
