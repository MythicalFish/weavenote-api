class RoleSerializer < ActiveModel::Serializer
  
  attributes :id, :role_type_id

  belongs_to :user
  belongs_to :roleable

end
