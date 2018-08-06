module Api
  class DaysController < ApplicationController
    def index
      render json: Pathe::Schedule.dates
    end
  end
end
