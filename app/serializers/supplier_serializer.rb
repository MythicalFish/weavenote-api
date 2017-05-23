class SupplierSerializer < ActiveModel::Serializer
  attributes :id, :name, :agent, :name_ref, :color_ref, :minimum_order, :comments
end
