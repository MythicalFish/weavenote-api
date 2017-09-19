class MeasurementValue < ApplicationRecord
  
  belongs_to :measurement_group
  belongs_to :measurement_name

  alias_attribute :group, :measurement_group
  alias_attribute :name, :measurement_name

  default_scope { order(created_at: :asc) }

end
