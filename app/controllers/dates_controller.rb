class DatesController < ApplicationController
  def index
    render json: Pathe::Schedule.dates
  end
end
