module Filmplanner
  class Combination
    class << self
      def combine(date, theater_ids, movie_ids: nil)
        new(date, theater_ids, movies_ids: movie_ids).combine
      end
    end

    def initialize(date, theater_ids, movie_ids: nil)
      @cache = Cache.new(date, theater_ids, movie_ids: movie_ids)
    end

    def movie_combinations
      (2..5).flat_map { |i| @cache.movie_ids.combination(i).to_a }
    end

    def show_combinations(movie_ids)
      @cache.shows_by_movies(movie_ids).inject(&:product).map { |c| [c].flatten }
    end

    def combine
      Suggestion.bulk_insert(set_size: 10000) do |worker|
        movie_combinations.each do |movie_ids|
          show_combinations = show_combinations(movie_ids)

          show_combinations.each do |shows|
            next unless Show.attainable?(shows)

            worker.add(Suggestion.for_shows(shows))
          end
        end
      end
    end
  end
end
