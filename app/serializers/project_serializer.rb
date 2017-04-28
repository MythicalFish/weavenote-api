class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :identifier, :stage, :images, :archived
end
