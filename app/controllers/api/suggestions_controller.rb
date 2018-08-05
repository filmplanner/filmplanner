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
      param_to_array(params[:theater_ids])
    end

    def movie_ids
      param_to_array(params[:movie_ids])
    end
  end
end
