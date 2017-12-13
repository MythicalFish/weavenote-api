class ComponentSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :project_id
  belongs_to :material
end
