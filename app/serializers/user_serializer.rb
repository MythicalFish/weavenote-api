class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :avatar, :abilities, :organization, :organizations, :organization_role_type
end
