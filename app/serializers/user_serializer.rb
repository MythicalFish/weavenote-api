class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :avatar, :abilities, :organization, :organizations, :role
end
