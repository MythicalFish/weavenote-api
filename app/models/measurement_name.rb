class MeasurementName < ApplicationRecord
  
  belongs_to :project, dependent: :destroy
  has_many :measurement_values

  default_scope { order(value: :desc) }

end
