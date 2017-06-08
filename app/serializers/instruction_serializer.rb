class InstructionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :project_id
  has_one :image
end
