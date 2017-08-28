class ProjectListSerializer < ActiveModel::Serializer
  attributes :id, :name, :ref_number, :stage, :archived, 
  :avatar_list, :collection, :thumbnail_url, :created_at
end
