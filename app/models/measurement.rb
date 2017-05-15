class Measurement < ApplicationRecord
  
  belongs_to :project
  has_many :measurement_values

end
