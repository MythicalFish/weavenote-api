class MaterialTypesController < ApplicationController

  # GET /material_types
  def index
    @types = MaterialType.all.order('name ASC')
    render json: @types
  end

end
