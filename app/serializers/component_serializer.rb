class ComponentSerializer < ActiveModel::Serializer
  attributes :id, :quantity
  belongs_to :material
end
