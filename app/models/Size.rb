class Size < ApplicationRecord
  
  belongs_to :project
  has_many :measurement_values
  has_many :measurements, through: :project

  def values
    values = []
    measurements.each do |measurement|
      values << value_for(measurement)
    end
    values
  end

  def value_for(measurement)
    measurement_values.find_by_measurement_id(measurement.id) || 0
  end


end
