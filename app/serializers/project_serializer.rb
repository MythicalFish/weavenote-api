class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :identifier, :stage, :archived, :category
end
