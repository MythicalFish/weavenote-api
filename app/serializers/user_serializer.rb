class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :email, :avatar, :abilities, :organizations, :role
  belongs_to :organization, serializer: OrganizationSerializer
end
