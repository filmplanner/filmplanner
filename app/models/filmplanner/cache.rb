module Filmplanner
  class Cache
    def initialize(date, theater_ids)
      @date         = date
      @theater_ids  = theater_ids
    end

    def shows
      @shows ||= Show.where(date: @date, theater_id: @theater_ids).order(:start_at)
    end

    def movie_ids
      @movie_ids ||= shows.pluck(:movie_id).uniq
    end

    def shows_by_movie
      @shows_by_movie ||= shows.group_by(&:movie_id)
    end

    def shows_by_movies(movie_ids)
      [movie_ids].flatten.map { |movie_id| shows_by_movie[movie_id] }
    end
  end
end
