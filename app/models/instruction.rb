class Instruction < ApplicationRecord

  belongs_to :project
  has_many :images, as: :imageable, before_add: :enforce_single_image

  validates :title, length: { minimum: 3 }

  private

  def enforce_single_image image
    images.destroy_all
  end

end