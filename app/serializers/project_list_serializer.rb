class ProjectListSerializer < ActiveModel::Serializer
  attributes :id, :name, :ref_number, :stage, :archived, 
  :collaborators, :collection, :thumbnail_url, :created_at
end
