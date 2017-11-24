class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :notes, :ref_number, :stage, :archived, :color_code, :target_fob,
  :collection, :thumbnail_url, :created_at, :material_cost, :development_stage, :role_types, :all_collaborators
end
