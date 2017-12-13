class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :email, :avatar, :abilities, :organizations, :role_type
  belongs_to :organization, serializer: OrganizationSerializer
end
