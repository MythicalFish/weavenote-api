class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :name, :role_types, :has_active_subscription
end