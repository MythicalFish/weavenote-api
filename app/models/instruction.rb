class Instruction < ApplicationRecord

  belongs_to :project
  has_many :images, as: :imageable

  validates :title, length: { minimum: 3 }

end