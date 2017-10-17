class MaterialSerializer < ActiveModel::Serializer
  
  attributes :id, :name, :identifier, :composition, :size, :length, :subtype, :opening_type,
    :currency, :cost_base, :cost_delivery, :cost_extra1 , :cost_extra2, :cost_total, :care_label_ids,
    :supplier_name, :supplier_email

  belongs_to :type
  belongs_to :currency
  has_one :image
  has_one :unit_type
  
end
