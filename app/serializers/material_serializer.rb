class MaterialSerializer < ActiveModel::Serializer
  
  attributes :id, :name, :identifier, :composition, :size, :length, :subtype, :opening_type,
    :currency, :cost_base, :cost_delivery, :cost_extra1 , :cost_extra2, :cost_total, :care_label_ids

  belongs_to :type
  belongs_to :color
  belongs_to :currency
  belongs_to :supplier
  has_one :image

end
