class SupplierSerializer < ActiveModel::Serializer
  attributes :id, :name, :agent, :ref, :color_ref, :minimum_order, :comments, :subtype
end
