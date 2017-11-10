class Component < ApplicationRecord
  
  belongs_to :project
  belongs_to :material

  def material_cost
    (material.cost_total || 0) * (quantity || 0)
  end

end
