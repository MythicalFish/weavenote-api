class Material < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :material_type
  belongs_to :color
  belongs_to :currency
  has_and_belongs_to_many :care_labels
  belongs_to :supplier, optional: true
  accepts_nested_attributes_for :supplier

  alias_attribute :type, :material_type

  before_validation :set_currency
  before_validation :set_supplier_user

  def cost_total
    cost_base + cost_delivery + cost_extra1 + cost_extra1
  end

  private

  def set_supplier_user
    if self.supplier
      unless self.supplier.user_id
        self.supplier.user_id = self.user_id
      end
    end
  end

  def set_currency
    unless self.currency_id
      self.currency_id = Currency.find_by_iso_code('GBP').id
    end
  end

end
