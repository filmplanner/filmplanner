class Suggestion < ApplicationRecord
  class << self
    def for_shows(shows)
      shows = [shows].flatten

      suggestion = Suggestion.find_or_initialize_by(
        key: SuggestionKey.join(shows.map(&:full_key))
      )

      suggestion.update(
        show_key:         SuggestionKey.join(shows.map(&:to_key)),
        movie_key:        SuggestionKey.join(shows.map(&:movie_key)),
        theater_key:      SuggestionKey.join(shows.map(&:theater_key)),
        date:             shows.first.date,
        start_at:         shows.first.start_at,
        end_at:           shows.last.end_at,
        wait_time:        Show.wait_time_for(shows),
        shows_amount:     shows.length,
        theaters_amount:  shows.map(&:theater_id).uniq.length
      )
      suggestion
    end
  end

  def theaters
    Theater.for_key(theater_key)
  end

  def movies
    Movie.for_key(movie_key)
  end

  def shows
    Show.for_key(show_key)
  end
end
