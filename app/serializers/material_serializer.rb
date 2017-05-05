class MaterialSerializer < ActiveModel::Serializer
  attributes :id, :name, :identifier, :price
  belongs_to :type
  belongs_to :color
end
