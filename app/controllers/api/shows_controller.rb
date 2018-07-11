module Api
  class ShowsController < ApplicationController
    def index
      render json: Show.where(
        date:       params[:date],
        theater_id: params[:theater_ids]
      )
    end
  end
end
