class RoleSerializer < ActiveModel::Serializer
  
  attributes :id, :role_type_id, :role_type_name

  belongs_to :user
  belongs_to :roleable

end
