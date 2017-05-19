class Material < ApplicationRecord
  belongs_to :user
  belongs_to :material_type
  belongs_to :color

  alias_attribute :type, :material_type

  before_validation :set_currency

  private

  def set_currency
    unless self.currency_id
      self.currency_id = Currency.find_by_iso_code('GBP')
    end
  end

end
