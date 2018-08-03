module Api
  class SuggestionsController < ApplicationController
    def index
      render json: Filmplanner::Combination.combine(
        date:         date,
        theater_ids:  theater_ids,
        movie_ids:    movie_ids
      )
    end

    private

    def date
      params[:date]
    end

    def theater_ids
      Array(params[:theater_ids]).map(&:to_i)
    end

    def movie_ids
      Array(params[:movie_ids]).map(&:to_i)
    end
  end
end
