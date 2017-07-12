class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :identifier, :stage, :archived, 
  :category, :thumbnail_url, :created_at, :material_cost
  has_many :images
  has_many :comments
end
