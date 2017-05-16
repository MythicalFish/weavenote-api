class MeasurementName < ApplicationRecord
  
  belongs_to :project
  has_many :measurements

  default_scope { order(name: :desc) }

end
