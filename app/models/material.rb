class Material < ApplicationRecord
  belongs_to :user
  has_one :material_type
end
