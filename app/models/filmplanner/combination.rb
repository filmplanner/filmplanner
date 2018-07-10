module Filmplanner
  class Combination
    MAX_MOVIE_AMOUNT = 5

    class << self
      def combine(date:, theater_ids:, movie_ids: [])
        new(date, theater_ids, movie_ids).combine
      end
    end

    def initialize(date, theater_ids, movie_ids = [])
      @cache      = Cache.new(date, theater_ids)
      @movie_ids  = movie_ids
    end

    def movie_combinations
      combine_movies(@movie_ids) + combine_suggested_movies(@movie_ids, @cache.movie_ids - @movie_ids)
    end

    def combine_movies(movie_ids)
      length = [movie_ids.length, MAX_MOVIE_AMOUNT].min

      (1..length).flat_map { |i| movie_ids.combination(i).to_a }
    end

    def combine_suggested_movies(movie_ids, suggested_movie_ids)
      suggested_movie_ids.map { |movie_id| movie_ids + [movie_id] }
    end

    def combine_shows(movie_ids)
      shows_by_movie = @cache.shows_by_movies(movie_ids)

      shows_by_movie.inject(&:product).map { |combination| [combination].flatten }
    end

    def combine
      movie_combinations.inject([]) do |suggestions, movie_ids|
        show_combinations = combine_shows(movie_ids)

        show_combinations.each do |shows|
          suggestions << Suggestion.for_shows(shows) if Show.attainable?(shows)
        end

        suggestions
      end
    end
  end
end
