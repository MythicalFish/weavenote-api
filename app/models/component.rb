class Component < ApplicationRecord
  
  belongs_to :project, dependent: :destroy
  belongs_to :material

  def material_cost
    material.cost_total * quantity
  end

end
