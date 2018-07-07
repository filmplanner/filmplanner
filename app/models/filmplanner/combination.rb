module Filmplanner
  class Combination
    class << self
      def combine(date, theater_ids)
        new(date, theater_ids).combine
      end
    end

    def initialize(date, theater_ids)
      @cache = Cache.new(date, theater_ids)
    end

    def movie_combinations
      (1..5).flat_map { |i| @cache.movie_ids.combination(i).to_a }
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
