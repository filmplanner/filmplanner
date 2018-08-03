module Api
  class MoviesController < ApplicationController
    def index
      render json: {
        movies: shows.map(&:movie).uniq,
        shows:  shows
      }
    end

    private

    def shows
      Show.includes(:movie).where(date: params[:date], theater_id: params[:theater_ids])
    end
  end
end
