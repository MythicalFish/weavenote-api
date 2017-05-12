class Component < ApplicationRecord
  
  belongs_to :project
  belongs_to :material

  def material_cost
    material.price * quantity
  end

end
