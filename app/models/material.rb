class Material < ApplicationRecord

  belongs_to :organization
  belongs_to :material_type
  alias_attribute :type, :material_type
  belongs_to :color
  belongs_to :currency
  has_and_belongs_to_many :care_labels
  belongs_to :supplier, optional: true
  accepts_nested_attributes_for :supplier
  has_many :images, as: :imageable, before_add: :destroy_images
  has_one :unit_type

  before_validation :set_currency
  before_validation :configure_supplier

  def cost_total
    (cost_base||0) + (cost_delivery||0) + (cost_extra1||0) + (cost_extra2||0)
  end

  def image
    images.first
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

  def destroy_images image
    # Material should only have 1 image, so we
    # destroy all images before adding a new one.
    # This is easier than modifying images_controller
    # to work with has_one.
    images.destroy_all
  end

end
