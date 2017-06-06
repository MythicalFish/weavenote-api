class MaterialTypesController < ApplicationController

  # GET /material_types
  def index
    @types = MaterialType.to_hash
    render json: @types
  end

end
