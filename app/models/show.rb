class Show < ApplicationRecord
  include Keyable

  belongs_to :movie
  belongs_to :theater

  class << self
    def wait_time(shows)
      shows.sort_by(&:start_at).each_cons(2).sum do |show, other|
        show.wait_time(other)
      end
    end

    def attainable?(shows)
      shows.sort_by(&:start_at).each_cons(2).all? do |show, other|
        show.ends_before?(other)
      end
    end
  end

  def movie_key
    Movie.key_for(movie_id)
  end

  def theater_key
    Theater.key_for(theater_id)
  end

  def full_key
    to_key + movie_key + theater_key
  end

  def wait_time(other)
    (other.start_at - end_at)
  end

  def ends_before?(other)
    end_at < other.start_at
  end
end
