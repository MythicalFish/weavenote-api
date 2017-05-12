class Component < ApplicationRecord
  
  belongs_to :project
  belongs_to :material

  def price
    material.price * quantity
  end

end
