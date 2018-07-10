class Suggestion < ApplicationRecord
  class << self
    def for_shows(shows)
      shows = [shows].flatten

      {
        key:              Key.join(shows.map(&:full_key)),
        show_key:         Key.join(shows.map(&:to_key)),
        movie_key:        Key.join(shows.map(&:movie_key)),
        theater_key:      Key.join(shows.map(&:theater_key)),
        date:             shows.first.date,
        start_at:         shows.first.start_at,
        end_at:           shows.last.end_at,
        wait_time:        Show.wait_time(shows),
        shows_amount:     shows.length,
        theaters_amount:  shows.map(&:theater_id).uniq.length
      }
    end
  end

  def theaters
    Theater.by_key(theater_key)
  end

  def movies
    Movie.by_key(movie_key)
  end

  def shows
    Show.by_key(show_key)
  end
end
