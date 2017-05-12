class ComponentSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :project_id, :material_cost
  belongs_to :material
end
