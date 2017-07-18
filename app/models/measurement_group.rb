class MeasurementGroup < ApplicationRecord
  
  belongs_to :project
  has_many :measurement_names, through: :project
  has_many :measurement_values

  validates :name, length: { minimum: 1, maximum: 3 }

end
