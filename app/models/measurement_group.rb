class MeasurementGroup < ApplicationRecord
  
  belongs_to :project, touch: true
  has_many :measurement_names, through: :project
  has_many :measurement_values, dependent: :delete_all

  default_scope { order(order: :asc) }

end
