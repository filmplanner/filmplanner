module Filmplanner
  class Selection
    def initialize(date, theater_ids, movie_ids)
      @date         = date
      @theater_ids  = theater_ids
      @movie_ids    = movie_ids
    end

    def theaters
      Theater.where(id: @theater_ids)
    end

    def movies
      Movie.where(id: @movie_ids)
    end

    def shows
      Show.where(date: @date, theater_id: @theater_ids, movie_id: @movie_ids)
    end

    def suggestions
      Combination.combine(date: date, theater_ids: theater_ids, movie_ids: movie_ids)
    end
  end
end
