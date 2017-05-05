class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :identifier, :stage, :archived, :category, :thumbnail_url
end
