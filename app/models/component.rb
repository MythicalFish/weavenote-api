class Component < ApplicationRecord
  
  belongs_to :project
  belongs_to :material

  def material_cost_in currency
    (material.cost_total_in(currency) || 0) * (quantity || 0)
  end

end
