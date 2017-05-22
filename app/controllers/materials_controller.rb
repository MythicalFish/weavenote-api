class MaterialsController < ApplicationController
  before_action :set_material, only: [:update, :destroy]

  # GET /materials
  def index
    @materials = @user.materials
      .order('created_at DESC')
    render json: @materials
  end

  # GET /materials/:id
  def show
    if params[:id] === 'new'
      @material = Material.new
    else
      set_material
    end
    render json: @material
  end

  # POST /materials
  def create
    @material = @user.materials.new(material_params)
    if @material.save
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
      params.require(:material).permit(
        :color_id, :material_type_id, :currency_id, :supplier_id, :care_labels,
        :name, :identifer, :composition, :size, :length, :opening_type, 
        :cost_base, :cost_delivery, :cost_extra1 , :cost_extra2 , 
      )
    end
end
