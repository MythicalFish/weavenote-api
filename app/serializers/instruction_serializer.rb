class InstructionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description
  has_one :image
end
