module Api
  class MoviesController < ApplicationController
    def index
      shows = Show.includes(:movie).where(date: date, theater_id: theater_ids)

      render json: {
        movies: shows.map(&:movie).uniq,
        shows:  shows
      }
    end

    private

    def date
      params[:date]
    end

    def theater_ids
      param_to_array(params[:theater_ids])
    end
  end
end
