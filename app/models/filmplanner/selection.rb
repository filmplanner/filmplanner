module Filmplanner
  class Selection
    def initialize(date, theater_ids)
      @date = date
      @theater_ids = theater_ids
    end

    def theaters
      Theater.where(id: @theater_ids)
    end

    def shows
      Show.includes(:movie).where(date: @date, theater_id: @theater_ids)
    end

    def movies
      shows.map(&:movie).uniq
    end

    def suggestions
      theater_key = SuggestionKey.from_keys(theaters.map(&:to_key))

      Suggestion.where(date: @date, theater_key: theater_key.all_keys)
    end
  end
end
