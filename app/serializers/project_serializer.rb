class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :notes, :ref_number, :stage, :archived, 
  :collection, :thumbnail_url, :created_at, :material_cost, :development_stage
  has_many :collaborators, serializer: CollaboratorSerializer
end
