class ColorsController < ApplicationController

  # GET /colors
  def index
    @types = Color.all.order('name ASC')
    render json: @types
  end

end
