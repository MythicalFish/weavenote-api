class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :identifier, :stage, :archived, 
  :category, :thumbnail_url, :created_at, :material_cost
  has_many :collaborators, serializer: CollaboratorSerializer
end
