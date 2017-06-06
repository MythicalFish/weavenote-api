class MaterialsController < ApplicationController
  before_action :set_material, only: [:update, :destroy]

  # GET /materials
  def index
    @materials = @organization.materials
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
    @material = @organization.materials.new(material_params)
    if @material.save
      render json: @material
    else
      render json: @material.errors.full_messages.join(', '), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /materials/:id
  def update
    if s = material_params[:supplier_attributes]
      @material.supplier_id = nil unless s[:id]
      @material.supplier_id = s[:id] if s[:id]
    end
    if @material.update(material_params)
      render json: @material
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
      @material = @organization.materials.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def material_params
      sanitized_params.permit(
        :color_id, :material_type_id, :currency_id, 
        :name, :identifer, :composition, :size, :length, :opening_type, :identifier, :subtype,
        :cost_base, :cost_delivery, :cost_extra1 , :cost_extra2 ,
        supplier_attributes: [ :id, :name, :agent, :ref, :color_ref, :minimum_order, :comments ],
        :care_label_ids => []
      )
    end

    def sanitized_params
      p = params[:material]
      if p[:supplier]
        p[:supplier_attributes] = p[:supplier]
        p.delete(:supplier)
      end
      if p[:type]
        p[:material_type_id] = p[:type][:id]
        p.delete(:type)
      end
      if p[:color]
        p[:color_id] = p[:color][:id]
        p.delete(:color)
      end
      if p[:currency]
        p[:currency_id] = p[:currency][:id]
        p.delete(:currency)
      end
      if p[:care_labels]
        ids = []
        p[:care_labels].each do |l|
          ids << l[:id]
        end
        p.delete(:care_labels)
        p[:care_label_ids] = ids
      end
      p
    end

end
