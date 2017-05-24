class ColorsController < ApplicationController

  # GET /colors
  def index
    @colors = Color.all.order('name ASC')
    render json: @colors
  end

end
