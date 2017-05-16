class MeasurementGroup < ApplicationRecord
  
  belongs_to :project
  has_many :measurement_names, through: :project
  has_many :measurements

  alias_attribute :names, :measurement_names

  def values
    values = []
    names.each do |name|
      values << value_for(name)
    end
    values
  end

  def value_for(name)
    measurements.find_by_measurement_name_id(name.id) || 
    Measurement.new({ group: self, name: name })
  end


end
