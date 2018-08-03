module Api
  class SuggestionsController < ApplicationController
    def index
      render json: Filmplanner::Combination.combine(
        date:         params[:date],
        theater_ids:  Array(params[:theater_ids]),
        movie_ids:    Array(params[:movie_ids])
      )
    end
  end
end
