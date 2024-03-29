class Material < ApplicationRecord

  belongs_to :organization
  belongs_to :material_type
  alias_attribute :type, :material_type
  belongs_to :currency
  has_and_belongs_to_many :care_labels
  belongs_to :supplier, optional: true
  accepts_nested_attributes_for :supplier
  has_one :image, as: :imageable
  belongs_to :unit_type
  has_many :components, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  
  amoeba { enable }

  before_validation :set_currency
  before_validation :configure_supplier

  validates :name, length: { minimum: 3 }

  default_scope { order('created_at DESC') }
  scope :active, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }

  def cost_total
    t = (cost_base||0) + (cost_delivery||0) + (cost_extra1||0) + (cost_extra2||0)
    t || 0
  end

  def cost_total_in iso_code
    return cost_total if currency.iso_code == iso_code
    return CurrencyConversion.do(cost_total, currency.iso_code, iso_code)
  end

  def display_name
    a = [name]
    n = type.try(:name)
    if n == "Yarn"
      a << yarn_count if yarn_count
    elsif ["Zip", "Button", "Other"].include? n
      a << size if size
    elsif n == "Other"
      a << other if other
    end
    if n == "Zip"
      a << length if length
      a << opening_type if opening_type
    end
    a.join(', ')
  end

  private

  def configure_supplier
    if self.supplier
      unless self.supplier.organization
        self.supplier.organization = self.organization
      end
    end
  end

  def set_currency
    unless self.currency_id
      self.currency_id = Currency.find_by_iso_code('GBP').id
    end
  end

end
