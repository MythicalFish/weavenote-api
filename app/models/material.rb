class Material < ApplicationRecord
  belongs_to :user
  belongs_to :material_type
  belongs_to :color
  belongs_to :currency
  belongs_to :supplier, optional: true
  has_and_belongs_to_many :care_labels

  alias_attribute :type, :material_type

  before_validation :set_currency

  def cost_total
    cost_base + cost_delivery + cost_extra1 + cost_extra1
  end

  private

  def set_currency
    unless self.currency_id
      self.currency_id = Currency.find_by_iso_code('GBP').id
    end
  end

end
