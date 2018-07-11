module Api
  class MoviesController < ApplicationController
    def index
      render json: Show.includes(:movie).where(
        date:       params[:date],
        theater_id: params[:theater_ids]
      ).map(&:movie).uniq
    end
  end
end
