class MaterialSerializer < ActiveModel::Serializer
  
  attributes :id, :name, :reference, :composition, :size, :length, :subtype, :opening_type,
    :currency, :cost_base, :cost_delivery, :cost_extra1 , :cost_extra2, :cost_total, :care_label_ids,
    :supplier_name, :supplier_email, :color

  belongs_to :type
  belongs_to :currency
  belongs_to :unit_type
  has_one :image
  
end
