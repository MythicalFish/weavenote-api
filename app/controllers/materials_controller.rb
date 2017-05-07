class MaterialsController < ApplicationController
  before_action :set_material, only: [:show, :update, :destroy]

  # GET /materials
  def index
    @materials = @user.materials
      .order('created_at DESC')
    render json: @materials
  end

  # GET /materials/:id
  def show
    render json: @material
  end

  # POST /materials
  def create
    @material = @user.materials.new(material_params)
    if @material.save
      #render json: @material, status: :created, location: @material
      index
    else
      render json: @material.errors.full_messages.join(', '), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /materials/:id
  def update
    if @material.update(material_params)
      if params[:index_after_update]
        index
      else 
        render json: @material
      end
    else
      render json: @material.errors, status: :unprocessable_entity
    end
  end

  # DELETE /materials/:id
  def destroy
    @material.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material
      @material = @user.materials.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def material_params
      params.require(:material).permit(:name, :identifer, :price, :color_id, :material_type_id)
    end
end
