module Parsers
  class ShowParser < RecordParser
    def klass
      Show
    end

    def start_at
      datetime = DateTimeParser.parse(@hash[:date], @hash[:start_at])
      return datetime if datetime > @hash[:date] + 8.hours

      datetime + 1.day
    end

    def end_at
      datetime = DateTimeParser.parse(@hash[:date], @hash[:end_at])
      return datetime if datetime > start_at

      datetime + 1.day
    end

    def initialize_by
      {
        movie:    @options[:movie],
        theater:  @options[:theater],
        date:     @hash[:date],
        start_at: start_at,
        end_at:   end_at
      }
    end

    def attributes
      {
        version:  @hash[:version],
        url:      @hash[:url]
      }
    end
  end
end
