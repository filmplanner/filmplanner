class SuggestionsController < ApplicationController
  def index
    render json: Filmplanner::Combination.combine(
      date:         params[:date],
      theater_ids:  params[:theater_ids],
      movie_ids:    params[:movie_ids] || []
    )
  end
end
