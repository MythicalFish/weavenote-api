class MaterialSerializer < ActiveModel::Serializer
  attributes :id, :name, :identifier, :cost_base, :cost_delivery, :cost_extra1 , :cost_extra2, :cost_total
  belongs_to :type
  belongs_to :color
end
