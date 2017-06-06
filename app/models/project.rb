class Project < ApplicationRecord

  include Imageable

  belongs_to :organization
  belongs_to :development_stage
  has_many :components
  has_many :materials, through: :components
  has_many :images, as: :imageable
  has_many :measurement_groups
  has_many :measurement_names
  has_many :measurement_values, through: :measurement_groups
  has_many :instructions
  accepts_nested_attributes_for :images

  alias_attribute :stage, :development_stage

  before_validation :set_defaults

  scope :active, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }

  def thumbnail_url
    images.order('id DESC').first.try(:url)
  end

  def material_cost
    cost = 0.00
    components.each do |c|
      cost += c.material_cost
    end
    cost.round(2)
  end

  def measurement_values! 
    a = []
    measurement_groups.each do |group|
      measurement_names.each do |name|
        attributes = { measurement_name_id: name.id, measurement_group_id: group.id }
        value = measurement_values.where(attributes).last
        a << (value || measurement_values.new(attributes))
      end
    end
    a
  end

  private

  def set_defaults
    if self.identifier.blank?
      self.identifier = rand(36**4).to_s(36).upcase
    end
    if self.development_stage_id.blank?
      self.development_stage_id = DevelopmentStage.first.id
    end
  end

end
