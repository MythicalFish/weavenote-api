class AnnotationAnchor < ApplicationRecord
  belongs_to :annotation, required: false

  def x_percent
    x * 100
  end
  
  def y_percent
    y * 100
  end
  
end