class Project < ApplicationRecord

  belongs_to :user
  belongs_to :development_stage
  has_many :materials, through: :users
  has_many :images, as: :imageable
  accepts_nested_attributes_for :images

  alias_attribute :stage, :development_stage

  before_create :set_identifier

  scope :active, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }

  def thumbnail_url
    images.first.url
  end

  private

  def set_identifier
    if self.identifier.blank?
      self.identifier = rand(36**4).to_s(36).upcase
    end
  end

end
