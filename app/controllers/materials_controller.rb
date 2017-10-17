class MaterialsController < ApplicationController

  before_action :set_material, only: [:update, :destroy, :duplicate]

  before_action :check_ability!, except: [:index]

  def index
    render json: material_list
  end

  def show
    if params[:id] === 'new'
      @material = Material.new
    else
      set_material
    end
    render json: serialized(@material)
  end

  def create
    @material = @organization.materials.new(material_params)
    @material.save!
    render_success "Material created", serialized(@material)
  end

  def duplicate
    m = @material.amoeba_dup
    m.name = "Duplicate of #{@material.name}"
    m.save!
    index
  end

  def update
    @material.update!(material_params)
    render json: serialized(@material)
  end

  def destroy
    @material.destroy!
    index
  end

  private
  
  def material_list
    @organization.materials.order('created_at DESC')
  end

  def set_material
    @material = @organization.materials.find(params[:id])
  end

  def material_params
    sanitized_params.permit(
      :color, :material_type_id, :currency_id, 
      :name, :identifer, :composition, :size, :length, :opening_type, :identifier, :subtype,
      :cost_base, :cost_delivery, :cost_extra1 , :cost_extra2 , :supplier_name, :supplier_email, :unit_type_id, 
      :care_label_ids => [], 
    )
  end

  def sanitized_params
    p = params[:material]
    if p[:type]
      p[:material_type_id] = p[:type][:id]
      p.delete(:type)
    end
    if p[:unit_type]
      p[:unit_type_id] = p[:unit_type][:id]
      p.delete(:unit_type)
    end
    if p[:currency]
      p[:currency_id] = p[:currency][:id]
      p.delete(:currency)
    end
    p
  end

end
