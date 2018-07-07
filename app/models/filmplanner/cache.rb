module Filmplanner
  class Cache
    def initialize(date, theater_ids, movie_ids: nil)
      @date         = date
      @theater_ids  = theater_ids
      @movie_ids    = movie_ids
    end
    def shows
      @shows ||= begin
        shows =Show.where(date: @date, theater_id: @theater_ids).order(:start_at)
        shows = shows.where(movie_id: @movie_ids) if @movie_ids.present?
        shows
      end
    end

    def movie_ids
      @movie_ids ||= shows.pluck(:movie_id).uniq
    end

    def shows_by_movie
      @shows_by_movie ||= shows.group_by(&:movie_id)
    end

    def shows_by_movies(movie_ids)
      [movie_ids].flatten.map { |movie_id| shows_by_movie[movie_id] }.compact
    end
  end
end
