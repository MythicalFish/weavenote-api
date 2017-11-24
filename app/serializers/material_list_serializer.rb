class MaterialListSerializer < ActiveModel::Serializer
  
  attributes :id, :name, :reference, :composition, :color, :archived, :supplier_name, :cost_total

  belongs_to :type
  
end
