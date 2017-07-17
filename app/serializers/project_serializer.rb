class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :identifier, :stage, :archived, 
  :category, :thumbnail_url, :created_at, :material_cost
  has_many :images, serializer: ImageSerializer
  has_many :comments, serializer: CommentSerializer
  has_many :collaborators, serializer: CollaboratorSerializer
end
