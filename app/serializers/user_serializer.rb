class UserSerializer < ActiveModel::Serializer
  attributes :name, :email, :avatar
end
