class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :avatar, :abilities, :organizations, :role
  belongs_to :organization, serializer: OrganizationSerializer
end
