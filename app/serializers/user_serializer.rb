class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :avatar, :abilities
  belongs_to :organization
  has_many :organizations
end
