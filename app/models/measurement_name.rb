class MeasurementName < ApplicationRecord
  
  belongs_to :project
  has_many :measurement_values, dependent: :destroy
  has_many :annotations, as: :annotatable
  validates :value, length: { minimum: 1, maximum: 16 }

  default_scope { order(value: :asc) }

  def type
    self.class.name
  end

end
