class MeasurementGroup < ApplicationRecord
  
  belongs_to :project
  has_many :measurement_names, through: :project
  has_many :measurement_values, dependent: :destroy

end
