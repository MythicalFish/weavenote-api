class Instruction < ApplicationRecord

  belongs_to :project
  has_many :images, as: :imageable
  delegate :organization, to: :project
  validates :title, length: { minimum: 3 }

end