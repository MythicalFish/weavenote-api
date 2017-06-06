class ColorsController < ApplicationController

  # GET /colors
  def index
    @colors = Color.to_hash
    render json: @colors
  end

end
