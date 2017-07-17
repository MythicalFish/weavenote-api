class ProjectListSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :identifier, :stage, :archived, 
  :category, :thumbnail_url, :created_at
end
