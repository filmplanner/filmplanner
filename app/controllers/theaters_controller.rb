class TheatersController < ApplicationController
  def index
    render json: Theater.all
  end
end
