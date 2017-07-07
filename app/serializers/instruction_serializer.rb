class InstructionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :project_id
  has_many :images
end
