class Material < ApplicationRecord
  belongs_to :user
  belongs_to :material_type
  belongs_to :color

  alias_attribute :type, :material_type

end
