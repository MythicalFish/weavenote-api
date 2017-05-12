class Project < ApplicationRecord

  belongs_to :user
  belongs_to :development_stage
  has_many :components
  has_many :materials, through: :components
  has_many :images, as: :imageable
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

  private

  def set_defaults
    if self.identifier.blank?
      self.identifier = rand(36**4).to_s(36).upcase
    end
    if self.development_stage_id.blank?
      self.development_stage = DevelopmentStage.first
    end
  end

end
