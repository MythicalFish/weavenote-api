class MaterialListSerializer < ActiveModel::Serializer
  
  attributes :id, :display_name, :reference, :composition, :color, :archived, :supplier_name, :cost_total

  belongs_to :type
  belongs_to :currency
  
end
