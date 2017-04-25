class Project < ApplicationRecord

  belongs_to :user
  belongs_to :development_stage
  has_many :materials, through: :users
  has_many :images, as: :imageable
  accepts_nested_attributes_for :images

  alias_attribute :stage, :development_stage

  def thumbnail_url
    images.first.url
  end

end
