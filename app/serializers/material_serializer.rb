class MaterialSerializer < ActiveModel::Serializer
  attributes :id, :name, :identifier, :price, :color, :type
end
