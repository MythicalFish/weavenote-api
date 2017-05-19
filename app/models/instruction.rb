class Instruction < ApplicationRecord

  belongs_to :project
  has_many :images, as: :imageable
  accepts_nested_attributes_for :images

end