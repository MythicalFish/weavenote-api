class MeasurementName < ApplicationRecord
  
  belongs_to :project, dependent: :destroy
  has_many :measurement_values

  validates :value, length: { minimum: 1, maximum: 16 }

  default_scope { order(value: :asc) }

end