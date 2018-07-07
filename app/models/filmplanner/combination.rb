module Filmplanner
  class Combination
    MAX_MOVIE_AMOUNT = 5

    # Filmplanner::Combination.combine(date: Time.zone.tomorrow, theater_ids: [13, 5], movie_ids: [22416, 21381, 21743])
    class << self
      def combine(date:, theater_ids:, movie_ids: [])
        new(date, theater_ids, movie_ids).combine
      end
    end

    def initialize(date, theater_ids, movie_ids = [])
      @movie_ids  = movie_ids
      @cache      = Cache.new(date, theater_ids)
    end

    def movie_combinations
      if @movie_ids.present?
        combine_movies(@movie_ids) + combine_possible_movies(@movie_ids, @cache.movie_ids)
      else
        combine_movies(@cache.movie_ids)
      end
    end

    def combine_movies(movie_ids)
      (1..[movie_ids.length, MAX_MOVIE_AMOUNT].min).flat_map do |i|
        movie_ids.combination(i).to_a
      end
    end

    def combine_possible_movies(movie_ids, possible_movie_ids)
      return [] if movie_ids.length >= 5

      (possible_movie_ids - movie_ids).inject([]) do |combined_movie_ids, movie_id|
        combined_movie_ids << movie_ids + [movie_id]
      end
    end

    def combine_shows(movie_ids)
      (@cache.shows_by_movies(movie_ids).inject(&:product) || []).map { |c| [c].flatten }
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
